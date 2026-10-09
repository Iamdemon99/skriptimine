#!/usr/bin/env bash
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/config/settings.conf"

DATE=$(date '+%Y%m%d_%H%M%S')
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "Varukoopia loomine..."

if tar -czf "$ARCHIVE" -C "$BACKUP_SOURCE" . 2>/dev/null; then
    if [ -s "$ARCHIVE" ]; then
        echo "Varukoopia valmis: $ARCHIVE"
        echo "Suurus: $(du -h "$ARCHIVE" | cut -f1)"
        exit 0
    fi
fi

echo "Varukoopia ebaõnnestus."
exit 1
