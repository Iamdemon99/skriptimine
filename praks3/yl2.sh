#!/bin/bash
# Skript arvutab küpsisetordi jaoks vajaliku küpsistepakkide arvu

echo "Sisesta aluskandiku pikkus (cm):"
read kandik_pikkus

echo "Sisesta aluskandiku laius (cm):"
read kandik_laius

echo "Sisesta ühe küpsise pikkus (cm):"
read kypsis_pikkus

echo "Sisesta ühe küpsise laius (cm):"
read kypsis_laius

echo "Sisesta tordi kihtide arv:"
read kihid

echo "Sisesta küpsiste arv ühes pakis:"
read pakis

# Arvutused käsuga expr
pikkusesse=$(expr $kandik_pikkus / $kypsis_pikkus)
laiusesse=$(expr $kandik_laius / $kypsis_laius)
kihi_kypsised=$(expr $pikkusesse \* $laiusesse)
kokku_kypsiseid=$(expr $kihi_kypsised \* $kihid)

# Pakkide arvu leidmine (ümardamine ülespoole)
pakkide_arv=$(expr \( $kokku_kypsiseid + $pakis - 1 \) / $pakis)

echo ""
echo "Tordi tegemiseks on vaja $kokku_kypsiseid küpsist."
echo "Poest tuleb osta $pakkide_arv pakki."
