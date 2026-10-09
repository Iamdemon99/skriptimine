#!/bin/bash

SERVICE="${1:-cron}"

# 1. Kontrollime, kas teenuse unit-fail on süsteemis üldse olemas
if ! systemctl cat "$SERVICE" &>/dev/null && ! systemctl list-unit-files "$SERVICE.service" &>/dev/null; then
    echo "Teenust '$SERVICE' ei ole süsteemis olemas."
    exit 1
fi

# 2. Kui teenus on olemas, kontrollime kas see parajasti töötab
if systemctl is-active --quiet "$SERVICE"; then
    echo "Teenus '$SERVICE' töötab."
else
    echo "Teenus '$SERVICE' ei tööta."
fi
