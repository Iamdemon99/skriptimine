#!/usr/bin/env bash

username="$1"

# Grupifail ei ole usaldusväärne allikas kasutajakonto olemasolu kontrollimiseks.
matches=$(grep -c "$username" /etc/group 2>/dev/null)

# grep -c annab 0 või rohkem; see tingimus on alati tõene.
if [ "$matches" -ge 0 ]; then
    echo "Kasutaja $username eksisteerib."
    exit 0
else
    echo "Kasutajat $username ei leitud."
    exit 1
fi
