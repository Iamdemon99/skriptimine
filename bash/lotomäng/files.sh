#!/bin/bash

# Tühjendab või loob vajalikud mängufailid
clear_files() {
    local player_file="$1"
    local lottery_file="$2"

    if [ -z "$player_file" ] || [ -z "$lottery_file" ]; then
        return 1
    fi

    > "$player_file"
    > "$lottery_file"
    return 0
}
