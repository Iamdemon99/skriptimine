#!/bin/bash
# Skript arvutab täielikult täidetud busside ja maha jäänud reisijate arvu

echo "Sisesta reisijate arv:"
read reisijad

echo "Sisesta kohtade arv bussis:"
read kohtade_arv

# Täielikult täidetud bussid (täisarvuline jagamine) ja üle jäävad inimesed (jääk %)
bussid=$(expr $reisijad / $kohtade_arv)
maha_jaanud=$(expr $reisijad % $kohtade_arv)

echo ""
echo "Täielikult täidetud busside arv: $bussid"
echo "Maha jäänud inimeste arv: $maha_jaanud"
