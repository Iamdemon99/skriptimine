#!/bin/bash

LOG_FILE="logs/app.log"
ABSOLUTE_PATH="$(pwd)/$LOG_FILE"

echo "=== LOGIDE VAATAMINE ==="
echo "Logifaili allikas / asukoht: $ABSOLUTE_PATH"
echo "----------------------------------------"

if [ -f "$LOG_FILE" ]; then
    echo "Viimased logisissekanded:"
    tail -n 10 "$LOG_FILE"
else
    echo "Hoiatus: Logifail allikast $LOG_FILE puudub."
fi
