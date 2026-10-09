#!/usr/bin/env bash

service="$1"

# Kontrollib ainult, kas sellise nimega unit-file on süsteemis olemas.
# See ei tõenda, et teenus hetkel töötab.
if systemctl list-unit-files --type=service 2>/dev/null | awk '{print $1}' | grep -qx "${service}.service"; then
    echo "Teenus $service töötab."
    exit 0
else
    echo "Teenus $service ei tööta."
    exit 1
fi
