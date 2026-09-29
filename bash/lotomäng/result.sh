#!/bin/bash

# Võrdleb mängija ja loto numbreid ning loendab tabamused
check_matches() {
    local -a p_nums=($1)
    local -a l_nums=($2)
    local matches=0
    local p_num

    echo ""
    echo "--- TULEMUSTE KONTROLL ---"

    for p_num in "${p_nums[@]}"; do
        echo ""
        echo "Kontrollin numbrit $p_num..."
        if contains "$p_num" "${l_nums[@]}"; then
            echo "TABAMUS!"
            matches=$((matches + 1))
        else
            echo "Ei tabanud."
        fi
    done

    echo "$matches"
}

# Tagastab tekstilise hinnangu vastavalt tabamuste arvule
get_result_text() {
    local matches="$1"
    case "$matches" in
        5) echo "JACKPOT!" ;;
        4) echo "Väga hea tulemus!" ;;
        3) echo "Hea tulemus." ;;
        2) echo "Kaks tabamust." ;;
        1) echo "Üks tabamus." ;;
        0) echo "Seekord tabamusi ei olnud." ;;
    esac
}

# Kuvab lõpptulemuse ekraanile
show_result() {
    local name="$1"
    local matches="$2"
    local text="$3"

    echo ""
    echo "Mängija: $name"
    echo "Tabamusi: $matches / 5"
    echo "Hinnang: $text"
}

# Lisab tulemuse faili results.txt
save_result() {
    local results_file="$1"
    local name="$2"
    local p_nums_str="$3"
    local l_nums_str="$4"
    local matches="$5"
    local text="$6"
    local current_date=$(date)

    local -a p_nums=($p_nums_str)
    local -a l_nums=($l_nums_str)

    {
        echo "========================================"
        echo "Date: $current_date"
        echo "Player: $name"
        echo "Player numbers:"
        for n in "${p_nums[@]}"; do
            echo "$n"
        done
        echo "Lottery numbers:"
        for n in "${l_nums[@]}"; do
            echo "$n"
        done
        echo "Matches: $matches"
        echo "Result: $text"
    } >> "$results_file"
}
