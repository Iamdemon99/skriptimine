#!/bin/bash

# Abifunktsioon: kontrollib, kas element sisaldub massiivis
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

# Küsib mängija nime
read_player_name() {
    local name
    read -p "Sisesta oma nimi: " name
    if [ -z "$name" ]; then
        name="Unknown"
    fi
    echo "$name"
}

# Küsib ja valideerib mängija numbrid ning salvestab faili
read_player_numbers() {
    local player_file="$1"
    local -a numbers=()
    local num
    local current_count

    echo "Vali 5 erinevat numbrit vahemikust 1–50." >&2
    echo "" >&2

    while [ ${#numbers[@]} -lt 5 ]; do
        current_count=$((${#numbers[@]} + 1))
        read -p "Sisesta $current_count. number (1-50): " num

        # Kontroll 1: täisarv
        if [ -z "$num" ] || ! [[ "$num" =~ ^[0-9]+$ ]]; then
            echo "Viga: Sisestatud väärtus peab olema täisarv!" >&2
            continue
        fi

        # Kontroll 2: vahemik 1..50
        if [ "$num" -lt 1 ] || [ "$num" -gt 50 ]; then
            echo "Viga: Number peab olema vahemikus 1–50!" >&2
            continue
        fi

        # Kontroll 3: unikaalsus
        if contains "$num" "${numbers[@]}"; then
            echo "Viga: Oled numbri $num juba varem valinud!" >&2
            continue
        fi

        numbers+=("$num")
        echo "$num" >> "$player_file"
    done

    echo "${numbers[@]}"
}

# Kuvab mängija sisestatud numbrid
show_player_numbers() {
    local -a numbers=("$@")
    echo ""
    echo "Sinu valitud numbrid:"
    for n in "${numbers[@]}"; do
        echo "$n"
    done
}
