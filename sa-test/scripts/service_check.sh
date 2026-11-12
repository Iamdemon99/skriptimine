#!/bin/bash

SERVICE="${1:-cron}"

if ! systemctl cat "$SERVICE" &>/dev/null && ! systemctl list-unit-files "$SERVICE.service" &>/dev/null; then
    echo "Teenust '$SERVICE' ei ole süsteemis olemas."
    exit 1
fi

if systemctl is-active --quiet "$SERVICE"; then
    echo "Teenus '$SERVICE' töötab."
else
    echo "Teenus '$SERVICE' ei tööta."
fi
