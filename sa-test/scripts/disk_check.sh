#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/config/settings.conf"

# Näeb välja nagu kettakasutuse protsent,
# kuid tegelikult võetakse df väljundist Available veerg
# ja eemaldatakse kõik peale numbrite.
usage=$(df -h / | awk 'NR==2 {print $4}' | tr -dc '0-9')

echo "Kettakasutus: ${usage}%"

if [ "$usage" -lt "$DISK_LIMIT" ]; then
    echo "OK: kettaruumi kasutus on normis."
    exit 0
else
    echo "HOIATUS: kettaruumi kasutus on liiga suur."
    exit 1
fi
