#!/bin/bash
# Skript kontrollib, kas sisestatud täisarv on paaris või paaritu

read -p "Sisesta suvaline täisarv: " arv

# Leiame jäägi 2-ga jagamisel
jaak=$(expr $arv % 2)

# Tingimuslause paaris/paaritu kontrolliks
if [ $jaak -eq 0 ]; then
    echo "Antud arv on paaris"
else
    echo "Antud arv on paaritu"
fi
