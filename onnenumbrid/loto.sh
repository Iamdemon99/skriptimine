#!/bin/bash

# Ajutine fail numbrite kontrolliks ja hoidmiseks
ajutine_fail="ajutine_loto.txt"
> "$ajutine_fail" # Tühjendame faili juhuks, kui see oli varem olemas

# Genereerime numbreid seni, kuni ajutises failis on 5 rida
while [ $(wc -l < "$ajutine_fail") -lt 5 ]
do
    # Genereerime suvalise arvu vahemikus 1-50
    arv=$(( (RANDOM % 50) + 1 ))
    
    # Kontrollime grep -x abil, kas see täpne arv on juba failis olemas
    if ! grep -q -x "$arv" "$ajutine_fail"
    then
        echo "$arv" >> "$ajutine_fail"
    fi
done

# Küsime kasutajalt väljundi valikut
echo "Kuidas soovid tulemust kuvada?"
echo "1 - Kuva terminalis (stdout)"
echo "2 - Salvesta faili"
read -p "Sisesta valik (1 või 2): " valik

# Leiname praeguse kuupäeva ja kellaaja
praegune_aeg=$(date "+%d.%m.%Y %H:%M:%S")

if [ "$valik" = "2" ]
then
    # Salvestame faili (kasutame >> et mitte üle kirjutada)
    echo "Genereeritud: $praegune_aeg" >> tulemused.txt
    cat "$ajutine_fail" >> tulemused.txt
    echo "------------------------" >> tulemused.txt
    echo "Tulemused salvestati faili tulemused.txt"
else
    # Kuvame terminalis
    echo ""
    echo "Kuupäev ja kellaaeg: $praegune_aeg"
    echo "Genereeritud lotonumbrid:"
    cat "$ajutine_fail"
fi

# Kustutame ajutise faili
rm -f "$ajutine_fail"
