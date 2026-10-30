# MariaDB dump to SQLite

This Harbor task is about recovering college data from SQL backups. The agent must write a Python converter. The starting program exits without making a database.

## Run

Use Harbor 0.20 or a later compatible version, with Docker:

```sh
harbor run -p mariadb-dump-to-sqlite -a oracle
harbor run -p mariadb-dump-to-sqlite -a nop
python3 frontierswe-check.py mariadb-dump-to-sqlite
```

The first image build needs internet access to download the pinned Python base image. The agent and the verifier both run without network access. Oracle and nop do not need a paid model API.

## Contents and scoring

The agent's workspace has three sample dumps and a self-check. The twelve hidden dumps and their answers are in tests/data. All fifteen dumps were made with a real MariaDB 11.4 server filled with made-up college records. The rows, column details, indexes and foreign keys in the answers were read from that server, not produced by the reference converter.

The verifier runs in its own new container, built from tests/Dockerfile, and receives the agent's /app. Only root can read its tests and the reward file, and it runs the agent's code as a separate user without special rights. The agent's image is built from environment/workspace only, so neither the reference solution nor the hidden tests are in it.

Each of the 96 hidden tables earns 0.7 for exact rows and 0.3 for the correct schema and working constraints. The reward is the average. A failed conversion loses only its own tables. instruction.md describes the rules and the scoring, and the self-check uses the same scoring code as the verifier.

The task covers the MariaDB dump features listed in instruction.md. It does not need support for every MySQL feature. All college data is made up. No real backup, account passwords or earlier incident report is included.
