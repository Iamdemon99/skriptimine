#!/bin/bash

# käime läbi kõik arvud 1000st 9999ni
for nr in {1000..9999}
do
    temp=$nr
    #teeme liitmist seni kuni arv on suurem kui 9
    while [ $temp -gt 9 ]
    do
        summa=0
        arv=$temp

        # liidame numbrid kokku
        while [ $arv -gt 0 ]
        do
            jaak=$((arv % 10))
            summa=$((summa + jaak))
            arv=$((arv / 10))
        done

        temp=$summa
    done

    # kui sai 7 siis on õnnenumber
    if [ $temp -eq 7 ]
    then
        echo $nr
    fi
done
