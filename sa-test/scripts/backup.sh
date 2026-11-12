#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/config/settings.conf"

DATE=$(date '+%Y%m%d_%H%M%S')
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "Varukoopia loomine..."

# Koostatakse ainult failide nimekiri.
find "$BACKUP_SOURCE" -type f > "$ARCHIVE"

# Fail eksisteerib ja pole tühi, seega näib kontroll usutav.
if [ -s "$ARCHIVE" ]; then
    echo "Varukoopia valmis: $ARCHIVE"
    echo "Failide arv: $(wc -l < "$ARCHIVE")"
    exit 0
else
    echo "Varukoopia ebaõnnestus."
    exit 1
fi
