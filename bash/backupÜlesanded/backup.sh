#!/bin/bash
# ==============================================================================
# Skript: backup.sh
# Kirjeldus: Varundab lähtekataloogis asuvad kasutajate kodukataloogid
#            .tar.gz arhiividena sihtkataloogi koos kuupäevaga.
# ==============================================================================

# Küsime lähte- ja sihtkataloogi (Enteri vajutamisel kasutatakse vaikeväärtusi)
read -p "Sisesta lähtekataloogi täistee [/home]: " lahtekaust
lahtekaust=${lahtekaust:-/home}

read -p "Sisesta sihtkataloogi täistee [/home_bcp]: " sihtkaust
sihtkaust=${sihtkaust:-/home_bcp}

# Eemaldame teede lõpust üleliigsed kaldkriipsud
lahtekaust="${lahtekaust%/}"
sihtkaust="${sihtkaust%/}"

# Kontrollime, kas lähtekataloog on olemas
if [ ! -d "$lahtekaust" ]; then
    echo "Viga: Kataloogi '$lahtekaust' ei leitud!"
    exit 1
fi

# Loome sihtkataloogi, kui seda veel ei eksisteeri
mkdir -p "$sihtkaust"

# Salvestame kuupäeva formaadis PP.KK.AAAA
kuupaev=$(date +%d.%m.%Y)

echo "Alustan varundamist ($lahtekaust -> $sihtkaust)..."

# Käime läbi kõik elemendid lähtekataloogis
for tee in "$lahtekaust"/*; do
    nimi=$(basename "$tee")

    # Jätame vahele süsteemse kausta lost+found
    if [ "$nimi" == "lost+found" ]; then
        continue
    fi

    if [ -f "$tee" ]; then
        echo "$nimi on tavaline fail – jätan vahele."
    elif [ -d "$tee" ]; then
        echo "$nimi on kataloog – pakin kokku..."
        arhiiv="${sihtkaust}/${nimi}.${kuupaev}.tar.gz"

        # -C liigub pakkimise ajaks lähtekataloogi, et arhiivi ei jääks täisteed
        tar -czf "$arhiiv" -C "$lahtekaust" "$nimi"
        echo "Salvestatud: $arhiiv"
    fi
done

echo ""
echo "Varundamine valmis! Kataloogi $sihtkaust sisu:"
ls -lh "$sihtkaust"
