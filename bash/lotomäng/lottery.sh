#!/bin/bash

# Skripti asukoha kausta leidmine
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Funktsioonide laadimine eraldi failidest
source "$SCRIPT_DIR/files.sh"
source "$SCRIPT_DIR/input.sh"
source "$SCRIPT_DIR/lottery_func.sh"
source "$SCRIPT_DIR/result.sh"

# Konstantsed failinimed
PLAYER_FILE="player_numbers.txt"
LOTTERY_FILE="lottery_numbers.txt"
RESULTS_FILE="results.txt"

# --- PROGRAMMI TÖÖVOO JUHTIMINE ---

# Päise kuvamine
echo "========================================"
echo "            LOTO SIMULAATOR             "
echo "========================================"
echo ""

# Failide alustamine
clear_files "$PLAYER_FILE" "$LOTTERY_FILE"

# Mängija nime küsimine
player_name=$(read_player_name)

# Mängija numbrite küsimine ja kuvamine
player_numbers_str=$(read_player_numbers "$PLAYER_FILE")
read -r -a player_numbers <<< "$player_numbers_str"
show_player_numbers "${player_numbers[@]}"

# Võidunumbrite loosimine ja kuvamine
lottery_numbers_str=$(generate_lottery_numbers "$LOTTERY_FILE")
read -r -a lottery_numbers <<< "$lottery_numbers_str"
show_lottery_numbers "${lottery_numbers[@]}"

# Tulemuste kontroll ja arvutus
matches=$(check_matches "${player_numbers[*]}" "${lottery_numbers[*]}")
result_text=$(get_result_text "$matches")

# Tulemuste kuva ja salvestamine
show_result "$player_name" "$matches" "$result_text"
save_result "$RESULTS_FILE" "$player_name" "${player_numbers[*]}" "${lottery_numbers[*]}" "$matches" "$result_text"
