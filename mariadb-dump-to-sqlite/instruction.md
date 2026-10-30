# Move a college SQL backup into SQLite

A college system used MariaDB for its admissions, fees, library, hostel and exam records. The server is gone. All that is left is a SQL backup made with mariadb-dump 11.4. We need the data in SQLite, without losing any values or the rules between tables.

Write `/app/dump2sqlite.py`. It is run like this:

```sh
python3 /app/dump2sqlite.py input.sql output.db
```

The input is an uncompressed SQL dump. The output must be a real SQLite database. Exit with code 0 when the conversion is done. The output file will not exist when your program starts. Each dump is run in a new working folder, so do not expect the working folder to be /app. Keep all the code your converter needs under /app. Use Python 3.12 and its standard library only. This machine has no internet, no MariaDB server and no MySQL client.

## What the backups contain

Each backup holds one database, with InnoDB tables and utf8mb4 text. It may have been made with any of these options, alone or together: --hex-blob, --skip-extended-insert, --complete-insert and --compact. An INSERT may have one row or many rows, and may list the column names. Statements and rows can be long and can run over several lines. Table and column names can be reserved words, can contain spaces and can contain an escaped backtick. Names, rows and table layouts can differ from the samples.

Read quoted values as SQL values. A comma, semicolon, bracket or comment marker inside a string is part of the string. A quote character written twice inside a string stands for one quote. The MariaDB backslash escapes \0, \b, \n, \r, \t, \Z, \\, \' and \" stand for the characters they name. \% and \_ keep their backslash. After any other backslash, drop the backslash and keep the character. Text can contain emoji, non-English characters, newlines and NUL bytes. Binary values can contain any byte. They may be written as 0x hex or as quoted bytes, with or without a _binary prefix. BIT values may also be written as b'...'. Do not decode binary bytes as UTF-8.

Ignore comments, SET statements, LOCK and UNLOCK statements, USE, CREATE DATABASE, DROP TABLE and ALTER TABLE ... ENABLE KEYS or DISABLE KEYS. Also skip views, triggers and the temporary tables the dump declares for views. MariaDB versioned comments such as /*!40101 ... */ are not instructions to run. Triggers can sit between DELIMITER lines and can contain semicolons. Do not create views or triggers in the output. Do not send SQL to any outside server, and never run anything from the dump as Python or shell code.

## How values must be stored

Keep the column names and their order. Keep every row, including duplicate rows, NULLs, empty strings and empty tables. Row order does not matter. Declare each column with the SQLite type below, and store each value as that type:

| MariaDB type | SQLite type and value |
| --- | --- |
| TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT, BIT | INTEGER; a BIT value is its unsigned number |
| DECIMAL(p,s) | TEXT, with exactly s digits after the decimal point; never convert it to a float |
| FLOAT, DOUBLE | REAL |
| CHAR, VARCHAR, TEXT and its variants | TEXT, with the original Unicode text |
| DATE, DATETIME, TIMESTAMP, TIME | TEXT, exactly as written in the dump, including zero dates |
| BINARY, VARBINARY, BLOB and its variants | BLOB, with the exact bytes, including the padding of fixed-width columns |

NULL stays NULL in every type. Integers fit in signed 64 bits, BIT columns are at most 32 bits wide, and decimals have at most 30 digits in total. Dates and times are to the second, and the dumps were made in UTC. The dumps use MariaDB's normal backslash escaping, not NO_BACKSLASH_ESCAPES. There are no generated columns, partitioned tables, spatial values, enums, prefix indexes, expression indexes, routines or events. Every column type is in the table above, and no default is an expression, so there is nothing to guess.

## Rules between tables

Keep primary keys, including the column order of composite keys. Keep NOT NULL rules, constant defaults, unique indexes and ordinary indexes, including the indexes MariaDB makes for foreign keys. Index names may change, because in SQLite every index in the database needs its own name. The columns, column order and uniqueness of each index must stay the same. Use SQLite's normal binary comparison; you do not need to copy MariaDB's text comparison rules. Defaults are stored the same way as inserted values. A nullable column with no default is the same as DEFAULT NULL. AUTO_INCREMENT counters do not need to be copied.

Keep foreign keys, including composite keys, the referenced columns, and the ON DELETE and ON UPDATE actions. Rows may be dumped before the table they refer to, so the load order must not make a valid backup fail. The keys must work when a caller turns on PRAGMA foreign_keys=ON. For example, when a parent row is deleted, its child rows must be deleted or have their key set to NULL, as declared. Do not add extra user tables, views or triggers. SQLite's own internal tables are allowed.

## Check your work

Three public dumps and their expected answers are in /app/samples. The answers were read directly from MariaDB. Run:

```sh
python3 /app/self_check.py
```

It runs your converter and reports the data and schema results. You can read its code. It scores in the same way as the final check. The final check uses twelve other dumps, not the samples. For each dump, your program gets 60 seconds, 1 GiB of memory and a maximum output file size of 128 MiB. Each input is smaller than 10 MiB and has fewer than 20,000 rows. Do not rely on the sample names, file names or fixed answers.

Each table is worth up to 1 point: 0.7 if all its rows and the types of the stored values match, and 0.3 if its column types, NOT NULL rules, defaults, keys and indexes match and its constraints work. The final score is the average over all expected tables. A missing table scores 0. If a conversion fails, runs out of time or gives a file that cannot be read, that dump's tables score 0, and the other dumps are still checked. Extra user tables, views or triggers make that dump score 0. The starting program does no conversion and scores 0.
