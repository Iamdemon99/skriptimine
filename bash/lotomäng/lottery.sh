#!/bin/bash

# 1. Failide algseadistus (uue mängu alguses luuakse või tühjendatakse)
> player_numbers.txt
> lottery_numbers.txt

contains() {
    local item="$1"
    shift
    local element
    for element in "$@"; do
        if [ "$element" -eq "$item" ]; then
            return 0
        fi
    done
    return 1
}

# 2. Mängija nime küsimine
read -p "Sisesta oma nimi: " player_name

# Kui nime ei sisestata, kasuta nime Unknown
if [ -z "$player_name" ]; then
    player_name="Unknown"
fi

echo ""
echo "Tere, $player_name! Vali 5 erinevat numbrit vahemikust 1–50."
echo ""

# 3. Mängija numbrite sisestamine ja kontroll
player_numbers=()

while [ ${#player_numbers[@]} -lt 5 ]; do
    current_count=$((${#player_numbers[@]} + 1))
    read -p "Sisesta $current_count. number (1-50): " num

    # Kontroll 1: kas midagi sisestati ja kas tegemist on täisarvuga
    if [ -z "$num" ] || ! [[ "$num" =~ ^[0-9]+$ ]]; then
        echo "Viga: Sisestatud väärtus peab olema täisarv!"
        continue
    fi

    # Kontroll 2: kas number on vahemikus 1–50
    if [ "$num" -lt 1 ] || [ "$num" -gt 50 ]; then
        echo "Viga: Number peab olema vahemikus 1–50!"
        continue
    fi

    # Kontroll 3: kas number on juba valitud
    if contains "$num" "${player_numbers[@]}"; then
        echo "Viga: Oled numbri $num juba varem valinud!"
        continue
    fi

    # Kui kõik kontrollid läbitud, salvesta number
    player_numbers+=("$num")
    echo "$num" >> player_numbers.txt
done

echo ""
echo "Sinu valitud numbrid:"
for n in "${player_numbers[@]}"; do
    echo "$n"
done

# 4. Loosimine ($RANDOM abil 5 erinevat numbrit)
lottery_numbers=()

while [ ${#lottery_numbers[@]} -lt 5 ]; do
    # $RANDOM % 50 annab vahemiku 0..49, liidame 1 -> 1..50
    rand_num=$(( ($RANDOM % 50) + 1 ))

    # Kontrollime duplikaate
    if ! contains "$rand_num" "${lottery_numbers[@]}"; then
        lottery_numbers+=("$rand_num")
        echo "$rand_num" >> lottery_numbers.txt
    fi
done

echo ""
echo "Loositud võidunumbrid:"
for n in "${lottery_numbers[@]}"; do
    echo "$n"
done

# 5. Tulemuse kontrollimine
echo ""
echo "--- TULEMUSTE KONTROLL ---"
matches=0

for p_num in "${player_numbers[@]}"; do
    echo ""
    echo "Kontrollin numbrit $p_num..."
    
    if contains "$p_num" "${lottery_numbers[@]}"; then
        echo "TABAMUS!"
        matches=$((matches + 1))
    else
        echo "Ei tabanud."
    fi
done

# Hinnangu määramine vastavalt tabamuste arvule
case $matches in
    5) result_text="JACKPOT!" ;;
    4) result_text="Väga hea tulemus!" ;;
    3) result_text="Hea tulemus." ;;
    2) result_text="Kaks tabamust." ;;
    1) result_text="Üks tabamus." ;;
    0) result_text="Seekord tabamusi ei olnud." ;;
esac

echo ""
echo "Mängija: $player_name"
echo "Tabamusi: $matches / 5"
echo "Hinnang: $result_text"

current_date=$(date)

{
    echo "========================================"
    echo "Date: $current_date"
    echo "Player: $player_name"
    echo "Player numbers:"
    for n in "${player_numbers[@]}"; do
        echo "$n"
    done
    echo "Lottery numbers:"
    for n in "${lottery_numbers[@]}"; do
        echo "$n"
    done
    echo "Matches: $matches"
    echo "Result: $result_text"
} >> results.txt
