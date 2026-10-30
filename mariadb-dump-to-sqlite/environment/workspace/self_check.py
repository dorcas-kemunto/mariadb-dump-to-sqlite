#!/usr/bin/env python3
import argparse
import collections
import gzip
import json
import os
import pathlib
import pwd
import resource
import shutil
import signal
import sqlite3
import subprocess
import sys
import tempfile
import time


def q(name): return '"'+name.replace('"','""')+'"'
def normal(v): return {'blob':v.hex()} if isinstance(v,bytes) else v
def bag(rows): return collections.Counter(json.dumps(row,ensure_ascii=True,separators=(',',':')) for row in rows)


def default_value(c):
    s=c['default_sql']
    if s is None or s.upper()=='NULL': return None
    if s.startswith("b'"): return int(s[2:-1],2)
    if s.startswith("'") and s.endswith("'"):
        s=s[1:-1]; out=[]; i=0
        while i<len(s):
            if s[i]=='\\' and i+1<len(s):
                i+=1; out.append({'0':'\x00','n':'\n','r':'\r','t':'\t','b':'\b','Z':'\x1a'}.get(s[i],s[i]))
            elif s[i]=="'" and i+1<len(s) and s[i+1]=="'": out.append("'"); i+=1
            else: out.append(s[i])
            i+=1
        s=''.join(out)
    if c['type']=='INTEGER': return int(s)
    if c['type']=='REAL': return float(s)
    return s


def grouped_indices(meta):
    groups={}
    for i in meta['indices']: groups.setdefault(i['name'],[]).append(i)
    pk=[i['column'] for i in groups.pop('PRIMARY',[])]
    indices={(bool(items[0]['unique']),tuple(i['column'] for i in items)) for items in groups.values()}
    return pk,indices


def grouped_foreign(meta):
    groups={}
    for i in meta['foreign_keys']: groups.setdefault(i['name'],[]).append(i)
    return {(x[0]['table'],tuple(i['column'] for i in x),tuple(i['target'] for i in x),x[0]['on_update'],x[0]['on_delete']) for x in groups.values()}


def schema_check(db,name,meta):
    errors=[]
    cols=db.execute('PRAGMA table_info('+q(name)+')').fetchall()
    wanted=meta['columns']
    if [c[1] for c in cols]!=[c['name'] for c in wanted]: return ['column names or order differ']
    for got,c in zip(cols,wanted):
        if got[2].upper()!=c['type']: errors.append(c['name']+': storage type')
        if bool(got[3] or got[5]) != (c['nullable']=='NO'): errors.append(c['name']+': null rule')
        try:
            actual=db.execute('SELECT '+got[4]).fetchone()[0] if got[4] is not None else None
            if actual!=default_value(c) or type(actual)!=type(default_value(c)): errors.append(c['name']+': default')
        except (sqlite3.Error,ValueError): errors.append(c['name']+': invalid default')
    pk,indices=grouped_indices(meta)
    actual_pk=[c[1] for c in sorted(cols,key=lambda c:c[5]) if c[5]]
    if actual_pk!=pk: errors.append('primary key order')
    actual_indices=set()
    for idx in db.execute('PRAGMA index_list('+q(name)+')'):
        if idx[3]=='pk': continue
        fields=tuple(c[2] for c in db.execute('PRAGMA index_info('+q(idx[1])+')'))
        if idx[4]: errors.append('partial index')
        actual_indices.add((bool(idx[2]),fields))
    if actual_indices!=indices: errors.append('unique or ordinary indexes')
    fks={}
    for fk in db.execute('PRAGMA foreign_key_list('+q(name)+')'): fks.setdefault(fk[0],[]).append(fk)
    actual_fks=set()
    for group in fks.values():
        group.sort(key=lambda x:x[1]); first=group[0]
        actual_fks.add((first[2],tuple(x[3] for x in group),tuple(x[4] for x in group),first[5],first[6]))
    if actual_fks!=grouped_foreign(meta): errors.append('foreign keys or actions')
    if db.execute('SELECT 1 FROM '+q(name)+' LIMIT 1').fetchone():
        for c in wanted:
            if c['nullable']=='NO':
                db.execute('SAVEPOINT probe')
                rejected=False
                try: db.execute('UPDATE '+q(name)+' SET '+q(c['name'])+'=NULL')
                except sqlite3.IntegrityError: rejected=True
                finally: db.execute('ROLLBACK TO probe'); db.execute('RELEASE probe')
                if not rejected: errors.append(c['name']+': NULL accepted')
        for target,local,remote,update,delete in grouped_foreign(meta):
            db.execute('SAVEPOINT probe'); rejected=False
            c=next(c for c in wanted if c['name']==local[0])
            value=-919191919 if c['type']=='INTEGER' else '__missing_parent_919191__'
            try: db.execute('UPDATE '+q(name)+' SET '+q(local[0])+'=?',(value,))
            except sqlite3.IntegrityError: rejected=True
            finally: db.execute('ROLLBACK TO probe'); db.execute('RELEASE probe')
            if not rejected: errors.append('missing parent accepted')
            child=db.execute('SELECT '+','.join(map(q,local))+' FROM '+q(name)+' WHERE '+q(local[0])+' IS NOT NULL LIMIT 1').fetchone()
            if child:
                db.execute('SAVEPOINT probe')
                try:
                    before=db.execute('SELECT COUNT(*) FROM '+q(name)).fetchone()[0]
                    null_before=db.execute('SELECT COUNT(*) FROM '+q(name)+' WHERE '+q(local[0])+' IS NULL').fetchone()[0]
                    where=' AND '.join(q(c)+'=?' for c in local)
                    matched=db.execute('SELECT COUNT(*) FROM '+q(name)+' WHERE '+where,child).fetchone()[0]
                    db.execute('DELETE FROM '+q(target)+' WHERE '+' AND '.join(q(c)+'=?' for c in remote),child)
                    after=db.execute('SELECT COUNT(*) FROM '+q(name)).fetchone()[0]
                    if delete=='CASCADE' and after!=before-matched: errors.append('delete cascade did not run')
                    if delete=='SET NULL':
                        null_after=db.execute('SELECT COUNT(*) FROM '+q(name)+' WHERE '+q(local[0])+' IS NULL').fetchone()[0]
                        if after!=before or null_after!=null_before+matched: errors.append('delete set null did not run')
                except sqlite3.Error as exc: errors.append('delete action: '+str(exc))
                finally: db.execute('ROLLBACK TO probe'); db.execute('RELEASE probe')
    return errors


def inspect_output(path,expected):
    results=[]
    db=sqlite3.connect('file:'+str(path)+'?mode=ro',uri=True)
    writable=sqlite3.connect(':memory:'); db.backup(writable); db.close(); db=writable
    db.execute('PRAGMA foreign_keys=ON')
    try:
        if db.execute('PRAGMA integrity_check').fetchone()[0]!='ok': raise ValueError('database integrity check failed')
        tables={r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'")}
        extras=tables-set(expected['tables'])
        views=db.execute("SELECT name FROM sqlite_master WHERE type IN ('view','trigger')").fetchall()
        if extras or views: raise ValueError('unexpected table, view or trigger')
        for name,meta in expected['tables'].items():
            row={'table':name,'data':False,'schema':False,'errors':[]}
            try:
                actual=[[normal(v) for v in values] for values in db.execute('SELECT '+','.join(q(c['name']) for c in meta['columns'])+' FROM '+q(name))]
                row['data']=bag(actual)==bag(meta['rows'])
                if not row['data']: row['errors'].append('row values, types, duplicates or counts differ')
                errs=schema_check(db,name,meta)
                row['schema']=not errs; row['errors']+=errs
            except (sqlite3.Error,ValueError,TypeError) as exc: row['errors'].append(str(exc))
            results.append(row)
        return results
    finally: db.close()


def run_case(converter,sql,expected,run_user=None):
    result={'case':expected['case'],'tables':[], 'seconds':0}
    start=time.monotonic()
    with tempfile.TemporaryDirectory(prefix='dump-case-',dir='/tmp') as d:
        directory=pathlib.Path(d); source=directory/'input.sql'; output=directory/'output.db'
        source.write_bytes(sql)
        def restrict():
            resource.setrlimit(resource.RLIMIT_CPU,(60,60))
            resource.setrlimit(resource.RLIMIT_AS,(1024**3,1024**3))
            resource.setrlimit(resource.RLIMIT_FSIZE,(128*1024**2,128*1024**2))
            resource.setrlimit(resource.RLIMIT_NOFILE,(128,128))
            if run_user:
                user=pwd.getpwnam(run_user); os.setgroups([]); os.setgid(user.pw_gid); os.setuid(user.pw_uid)
        if run_user:
            user=pwd.getpwnam(run_user); os.chown(d,user.pw_uid,user.pw_gid)
        source.chmod(0o444)
        try:
            with open(directory/'stdout.log','wb') as out, open(directory/'stderr.log','wb') as err:
                p=subprocess.Popen([sys.executable,str(converter),str(source),str(output)],cwd=d,stdout=out,stderr=err,preexec_fn=restrict,start_new_session=True,env={'PATH':'/usr/local/bin:/usr/bin:/bin','LANG':'C.UTF-8','PYTHONDONTWRITEBYTECODE':'1'})
                try: p.wait(timeout=60)
                finally:
                    try: os.killpg(p.pid,signal.SIGKILL)
                    except ProcessLookupError: pass
            if p.returncode: raise ValueError('converter exit '+str(p.returncode)+': '+(directory/'stderr.log').read_bytes()[:600].decode(errors='replace'))
            if not output.is_file() or output.is_symlink(): raise ValueError('output database missing or symlink')
            result['tables']=inspect_output(output,expected)
        except (OSError,ValueError,sqlite3.Error,subprocess.TimeoutExpired) as exc:
            result['error']=str(exc)
            result['tables']=[{'table':n,'data':False,'schema':False,'errors':['conversion failed']} for n in expected['tables']]
    result['seconds']=round(time.monotonic()-start,3)
    return result


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--data',type=pathlib.Path,default=pathlib.Path(__file__).parent/'samples')
    parser.add_argument('--converter',type=pathlib.Path,default=pathlib.Path('/app/dump2sqlite.py'))
    parser.add_argument('--run-user')
    parser.add_argument('--reward',type=pathlib.Path)
    parser.add_argument('--report',type=pathlib.Path)
    args=parser.parse_args(); results=[]
    for answer in sorted(args.data.glob('*.json')):
        expected=json.loads(answer.read_text()); sql=answer.with_suffix('.sql')
        data=sql.read_bytes() if sql.exists() else gzip.decompress(sql.with_suffix('.sql.gz').read_bytes())
        case=run_case(args.converter.resolve(),data,expected,args.run_user); results.append(case)
        earned=sum(7*t['data']+3*t['schema'] for t in case['tables'])
        print(f"{case['case']}: {earned}/{10*len(case['tables'])} ({case['seconds']} seconds)",flush=True)
        if 'error' in case: print(case['error'],flush=True)
        for t in case['tables']:
            if t['errors']: print('  '+t['table']+': '+'; '.join(t['errors']),flush=True)
    total=sum(len(c['tables']) for c in results)
    if not total: raise SystemExit('no fixtures found')
    earned=sum(7*t['data']+3*t['schema'] for c in results for t in c['tables'])
    score=earned/(10*total)
    report={'score':score,'tables':total,'results':results}
    if args.report: args.report.write_text(json.dumps(report,indent=2)+'\n')
    if args.reward: args.reward.write_text(f'{score:.12f}\n')
    print(f'Score: {score:.6f}')


if __name__=='__main__': main()
