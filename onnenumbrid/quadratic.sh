#!/bin/bash

# 1. Kontrolli, et kasutaja sisestaks kolm argumenti
if [ "$#" -ne 3 ]; then
    echo "Viga: Sisesta täpselt 3 argumenti: A, B ja C."
    echo "Kasutamine: $0 <A> <B> <C>"
    exit 1
fi

A=$1
B=$2
C=$3

# 2. Kontrolli, et A ei oleks 0
if [ $(echo "$A == 0" | bc -l) -eq 1 ]; then
    echo "Viga: Kordaja A ei tohi olla 0."
    exit 1
fi

# 3. Arvuta diskriminant: D = B^2 - 4AC
D=$(echo "$B * $B - 4 * $A * $C" | bc -l)

# 4. Kontrolli diskriminanti ja arvuta lahendid
if [ $(echo "$D < 0" | bc -l) -eq 1 ]; then
    echo "Reaalarvulisi lahendeid ei ole."
elif [ $(echo "$D == 0" | bc -l) -eq 1 ]; then
    # Üks lahend: x = -B / (2A)
    x=$(echo "scale=10; -1 * ($B) / (2 * $A)" | bc -l)
    printf "Võrrandil on üks lahend: x = %.5f\n" "$x"
else
    # Kaks lahendit: x1,2 = (-B ± sqrt(D)) / (2A)
    x1=$(echo "scale=10; (-1 * ($B) + sqrt($D)) / (2 * $A)" | bc -l)
    x2=$(echo "scale=10; (-1 * ($B) - sqrt($D)) / (2 * $A)" | bc -l)

    printf "Võrrandil on kaks lahendit:\n"
    printf "x1 = %.5f\n" "$x1"
    printf "x2 = %.5f\n" "$x2"
fi
