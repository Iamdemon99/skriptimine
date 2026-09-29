#!/bin/bash

# Failide konstandid
PLAYER_FILE="player_numbers.txt"
LOTTERY_FILE="lottery_numbers.txt"
RESULTS_FILE="results.txt"

# Globaalsed muutujad
player_name=""
player_numbers=()
lottery_numbers=()
matches=0
result_text=""

# --- ABIFUNKTSIOONID ---

# Kontrollib, kas element on massiivis olemas
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

# --- PÕHIFUNKTSIOONID ---

show_header() {
    echo "========================================"
    echo "            LOTO SIMULAATOR             "
    echo "========================================"
    echo ""
}

clear_files() {
    > "$PLAYER_FILE"
    > "$LOTTERY_FILE"
}

read_player() {
    read -p "Sisesta oma nimi: " player_name
    if [ -z "$player_name" ]; then
        player_name="Unknown"
    fi
    echo ""
    echo "Tere, $player_name! Vali 5 erinevat numbrit vahemikust 1–50."
    echo ""
}

read_player_numbers() {
    while [ ${#player_numbers[@]} -lt 5 ]; do
        local current_count=$((${#player_numbers[@]} + 1))
        local num

        read -p "Sisesta $current_count. number (1-50): " num

        # Kontroll 1: täisarvu olemasolu
        if [ -z "$num" ] || ! [[ "$num" =~ ^[0-9]+$ ]]; then
            echo "Viga: Sisestatud väärtus peab olema täisarv!"
            continue
        fi

        # Kontroll 2: vahemik 1-50
        if [ "$num" -lt 1 ] || [ "$num" -gt 50 ]; then
            echo "Viga: Number peab olema vahemikus 1–50!"
            continue
        fi

        # Kontroll 3: duplikaadi kontroll
        if contains "$num" "${player_numbers[@]}"; then
            echo "Viga: Oled numbri $num juba varem valinud!"
            continue
        fi

        player_numbers+=("$num")
        echo "$num" >> "$PLAYER_FILE"
    done
}

show_player_numbers() {
    echo ""
    echo "Sinu valitud numbrid:"
    for n in "${player_numbers[@]}"; do
        echo "$n"
    done
}

generate_lottery_numbers() {
    while [ ${#lottery_numbers[@]} -lt 5 ]; do
        local rand_num=$(( ($RANDOM % 50) + 1 ))

        if ! contains "$rand_num" "${lottery_numbers[@]}"; then
            lottery_numbers+=("$rand_num")
            echo "$rand_num" >> "$LOTTERY_FILE"
        fi
    done
}

show_lottery_numbers() {
    echo ""
    echo "Loositud võidunumbrid:"
    for n in "${lottery_numbers[@]}"; do
        echo "$n"
    done
}

check_matches() {
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

    case $matches in
        5) result_text="JACKPOT!" ;;
        4) result_text="Väga hea tulemus!" ;;
        3) result_text="Hea tulemus." ;;
        2) result_text="Kaks tabamust." ;;
        1) result_text="Üks tabamus." ;;
        0) result_text="Seekord tabamusi ei olnud." ;;
    esac
}

show_result() {
    echo ""
    echo "Mängija: $player_name"
    echo "Tabamusi: $matches / 5"
    echo "Hinnang: $result_text"
}

save_result() {
    local current_date=$(date)

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
    } >> "$RESULTS_FILE"
}

# ==============================================================================
# PROGRAMMI PÕHIOSA
# ==============================================================================

show_header
clear_files
read_player
read_player_numbers
show_player_numbers
generate_lottery_numbers
show_lottery_numbers
check_matches
show_result
save_result
