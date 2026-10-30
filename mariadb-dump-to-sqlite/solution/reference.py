#!/usr/bin/env python3
import decimal
import os
import pathlib
import re
import sqlite3
import sys
import tempfile


NUMBER = re.compile(r'(?:0[xX][0-9a-fA-F]+|[+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?)')
WORD = re.compile(r'[A-Za-z_$][A-Za-z0-9_$]*')


def tokens(data):
    s = data.decode('latin1')
    s = re.sub(r'^DELIMITER\s+(?!;\s*$)\S+\s*$.*?^DELIMITER\s+;\s*$', '', s, flags=re.M | re.S)
    i = 0
    while i < len(s):
        c = s[i]
        if c.isspace(): i += 1; continue
        if s.startswith('/*', i):
            end = s.find('*/', i+2)
            if end < 0: raise ValueError('unterminated comment')
            i = end+2; continue
        if c == '#' or (s.startswith('--', i) and (i+2 == len(s) or s[i+2].isspace())):
            end = s.find('\n', i)
            i = len(s) if end < 0 else end+1
            continue
        if c in "'\"`":
            quote = c; i += 1; buf = bytearray()
            while i < len(s):
                c = s[i]; i += 1
                if c == quote:
                    if i < len(s) and s[i] == quote:
                        buf.append(ord(quote)); i += 1; continue
                    break
                if c == '\\' and quote != '`':
                    if i >= len(s): raise ValueError('unterminated escape')
                    c = s[i]; i += 1
                    escaped = {'0':0,'n':10,'r':13,'t':9,'b':8,'Z':26}
                    if c in ('%', '_'): buf.append(92)
                    buf.append(escaped.get(c, ord(c)))
                else: buf.append(ord(c))
            else: raise ValueError('unterminated quote')
            yield ('id', bytes(buf).decode('utf8')) if quote == '`' else ('str', bytes(buf))
            continue
        m = NUMBER.match(s, i)
        if m:
            yield m[0]; i += len(m[0]); continue
        m = WORD.match(s, i)
        if m:
            yield m[0]; i += len(m[0]); continue
        yield c; i += 1


def upper(t): return t.upper() if isinstance(t,str) else ''
def ident(t): return t[1] if isinstance(t,tuple) and t[0]=='id' else str(t)
def q(s): return '"'+s.replace('"','""')+'"'


def split_top(ts, sep=','):
    groups=[]; start=0; depth=0
    for i,t in enumerate(ts):
        if t=='(': depth+=1
        elif t==')': depth-=1
        elif t==sep and depth==0: groups.append(ts[start:i]); start=i+1
    groups.append(ts[start:])
    return groups


def bracket(ts, start):
    if ts[start]!='(': raise ValueError('expected parenthesis')
    depth=1
    for end in range(start+1,len(ts)):
        if ts[end]=='(': depth+=1
        elif ts[end]==')':
            depth-=1
            if depth==0: return ts[start+1:end],end+1
    raise ValueError('unclosed parenthesis')


def literal(ts):
    if len(ts)==1:
        t=ts[0]
        if isinstance(t,tuple) and t[0]=='str': return t[1]
        if upper(t)=='NULL': return None
        if isinstance(t,str) and t.lower().startswith('0x'): return bytes.fromhex(t[2:])
        return str(t)
    if len(ts)==2 and upper(ts[0]) in ('B','X','_BINARY','_UTF8MB4','_UTF8'):
        raw=ts[1][1]
        if upper(ts[0])=='B': return str(int(raw,2))
        if upper(ts[0])=='X': return bytes.fromhex(raw.decode())
        return raw
    raise ValueError('unsupported literal '+repr(ts))


def convert(v,c):
    if v is None: return None
    typ=c['type']
    if typ=='BLOB': return v if isinstance(v,bytes) else str(v).encode()
    if typ=='INTEGER':
        if isinstance(v,bytes):
            return int.from_bytes(v,'big') if c['source']=='BIT' else int(v)
        return int(v)
    if typ=='REAL': return float(v)
    text=v.decode('utf8') if isinstance(v,bytes) else str(v)
    if c['source'] in ('DECIMAL','NUMERIC'):
        with decimal.localcontext() as ctx:
            ctx.prec=80
            text=format(decimal.Decimal(text),f".{c['scale']}f")
    return text


def sql_literal(v):
    if v is None: return 'NULL'
    if isinstance(v,bytes): return "X'"+v.hex()+"'"
    if isinstance(v,(float,int)): return repr(v)
    return "'"+v.replace("'","''")+"'"


def create(ts,db,schemas):
    pos=2
    if upper(ts[pos])=='IF': pos+=3
    name=ident(ts[pos]); body,_=bracket(ts,pos+1)
    cols=[]; clauses=[]; indices=[]; pk=[]
    for part in split_top(body):
        first=upper(part[0])
        if first=='PRIMARY':
            inside,_=bracket(part,part.index('(')); pk=[ident(x[0]) for x in split_top(inside)]
            clauses.append('PRIMARY KEY ('+','.join(map(q,pk))+')')
        elif first in ('UNIQUE','KEY','INDEX'):
            unique=first=='UNIQUE'; n=2 if unique else 1
            idxname=ident(part[n]); inside,_=bracket(part,part.index('('))
            fields=[ident(x[0]) for x in split_top(inside)]
            indices.append((idxname,unique,fields))
        elif first in ('CONSTRAINT','FOREIGN'):
            start=next(i for i,t in enumerate(part) if upper(t)=='FOREIGN')
            local,p=bracket(part,start+2)
            if upper(part[p])!='REFERENCES': raise ValueError('missing reference')
            target=ident(part[p+1]); remote,p=bracket(part,p+2)
            clause='FOREIGN KEY ('+','.join(q(ident(x[0])) for x in split_top(local))+') REFERENCES '+q(target)+' ('+','.join(q(ident(x[0])) for x in split_top(remote))+')'
            while p<len(part):
                if upper(part[p])=='ON':
                    action=upper(part[p+2]); n=3
                    if action in ('SET','NO'): action+=' '+upper(part[p+3]); n=4
                    clause+=' ON '+upper(part[p+1])+' '+action; p+=n
                else: p+=1
            clauses.append(clause)
        else:
            cname=ident(part[0]); source=upper(part[1]); p=2; args=[]
            if p<len(part) and part[p]=='(': args,p=bracket(part,p)
            if source in ('TINYINT','SMALLINT','MEDIUMINT','INT','INTEGER','BIGINT','BIT','YEAR','BOOL','BOOLEAN'): typ='INTEGER'
            elif source in ('BINARY','VARBINARY','BLOB','TINYBLOB','MEDIUMBLOB','LONGBLOB'): typ='BLOB'
            elif source in ('FLOAT','DOUBLE','REAL'): typ='REAL'
            else: typ='TEXT'
            c={'name':cname,'source':source,'type':typ,'scale':int(args[2]) if source in ('DECIMAL','NUMERIC') and len(args)>2 else 0}
            clause=q(cname)+' '+typ
            if any(upper(part[i])=='NOT' and upper(part[i+1])=='NULL' for i in range(p,len(part)-1)): clause+=' NOT NULL'
            for j in range(p,len(part)):
                if upper(part[j])=='DEFAULT':
                    end=j+2
                    if upper(part[j+1]) in ('B','X','_BINARY','_UTF8','_UTF8MB4'): end+=1
                    clause+=' DEFAULT '+sql_literal(convert(literal(part[j+1:end]),c)); break
            cols.append(c); clauses.insert(len(cols)-1,clause)
    db.execute('CREATE TABLE '+q(name)+' ('+','.join(clauses)+')')
    for idx,unique,fields in indices:
        db.execute('CREATE '+('UNIQUE ' if unique else '')+'INDEX '+q(name+'__'+idx)+' ON '+q(name)+' ('+','.join(map(q,fields))+')')
    schemas[name]=cols


def insert(ts,db,schemas):
    pos=1
    if upper(ts[pos])=='IGNORE': pos+=1
    if upper(ts[pos])=='INTO': pos+=1
    name=ident(ts[pos]); pos+=1
    columns=schemas[name]
    if ts[pos]=='(':
        fields,pos=bracket(ts,pos)
        lookup={c['name']:c for c in columns}
        columns=[lookup[ident(x[0])] for x in split_top(fields)]
    if upper(ts[pos])!='VALUES': raise ValueError('expected VALUES')
    pos+=1; rows=[]
    while pos<len(ts):
        row,pos=bracket(ts,pos)
        values=split_top(row)
        if len(values)!=len(columns): raise ValueError('wrong column count')
        rows.append(tuple(convert(literal(v),c) for v,c in zip(values,columns)))
        if pos<len(ts) and ts[pos]==',': pos+=1
    db.executemany('INSERT INTO '+q(name)+' ('+','.join(q(c['name']) for c in columns)+') VALUES ('+','.join('?' for _ in columns)+')',rows)


def main(source,destination):
    dest=pathlib.Path(destination)
    fd,tmp=tempfile.mkstemp(prefix='.dump2sqlite-',dir=dest.parent); os.close(fd)
    db=None
    try:
        db=sqlite3.connect(tmp); db.execute('PRAGMA foreign_keys=OFF'); db.execute('BEGIN')
        schemas={}; statement=[]
        for t in tokens(pathlib.Path(source).read_bytes()):
            if t==';':
                if len(statement)>2 and upper(statement[0])=='CREATE' and upper(statement[1])=='TABLE': create(statement,db,schemas)
                elif statement and upper(statement[0])=='INSERT': insert(statement,db,schemas)
                statement=[]
            else: statement.append(t)
        if statement: raise ValueError('incomplete SQL statement')
        db.commit()
        if db.execute('PRAGMA foreign_key_check').fetchall(): raise ValueError('invalid foreign keys')
        db.close(); db=None
        os.replace(tmp,dest)
    finally:
        if db: db.close()
        if os.path.exists(tmp): os.unlink(tmp)


if __name__=='__main__':
    if len(sys.argv)!=3: raise SystemExit('usage: dump2sqlite.py input.sql output.db')
    main(sys.argv[1],sys.argv[2])
