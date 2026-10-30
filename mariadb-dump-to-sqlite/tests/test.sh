#!/bin/sh
set -eu
mkdir -p /logs/verifier
chmod 700 /logs/verifier
chmod -R go-rwx /tests
printf '0\n' > /logs/verifier/reward.txt
chown -hR runner:runner /app
python3 -I /tests/compare.py --data /tests/data --converter /app/dump2sqlite.py --run-user runner --reward /logs/verifier/reward.txt --report /logs/verifier/details.json
