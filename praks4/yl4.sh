#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Kaivita see skript koos arvuga mille paarsus soovid kontrollida. Näiteks: $0 3"
else
    arv=$1
    jaak=$(($arv % 2))
    if [ $jaak -eq 0 ]; then
        echo "$arv on paaris"
    else
        echo "$arv on paaritu"
    fi
fi
