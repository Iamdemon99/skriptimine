#!/usr/bin/env bash
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/config/settings.conf"

LOG_FILE="$BASE_DIR/logs/app.log"

echo "=== Viimased logisissekanded ==="
if [ -f "$LOG_FILE" ]; then
    tail -n 10 "$LOG_FILE"
else
    echo "Logifaili ei leitud: $LOG_FILE"
fi
