#!/bin/bash
# Praktiline töö - Elroni rongiinfo skript

# ANSI värvikoodid
PUNANE='\033[0;31m'
ROHELINE='\033[0;32m'
RESET='\033[0m'

# 1. Marsruudi valimine
echo "ELRONI RONGIINFO"
echo ""
echo "Vali marsruut:"
echo ""
echo "1 - Tartu -> Tallinn"
echo "2 - Tartu -> Valga"
echo "3 - Tartu -> Koidula"
echo ""
echo -n "Sisesta valik: "
read valik

# 2. Sisendi kontroll
if test -z "$valik"
then
    echo "Valik jäi sisestamata."
    exit 1
fi

# Marsruudi määramine
case $valik in
    1)
        lahtejaam="Tartu"
        sihtjaam="Tallinn"
        ;;
    2)
        lahtejaam="Tartu"
        sihtjaam="Valga"
        ;;
    3)
        lahtejaam="Tartu"
        sihtjaam="Koidula"
        ;;
    *)
        echo "Vigane valik!"
        exit 1
        ;;
esac

# 3. Päring Elroni API-st
api_url="https://elron.ee/live-map/stop/$lahtejaam"
api_vastus=$(curl -s "$api_url")

if test $? -ne 0 -o -z "$api_vastus"
then
    echo "Elroni API päring ebaõnnestus."
    exit 1
fi

# 5. & 7. Filtreeri sihtjaama väljumisajad (HH:MM)
ajad=$(echo "$api_vastus" | grep -o '{[^}]*}' | grep "\"sihtjaam\":\"$sihtjaam\"" | grep -o '"plaaniline_aeg":"[0-9:]*"' | cut -d'"' -f4)

# 6. Kontrolli, kas rongiaegu leiti
if test -z "$ajad"
then
    echo "Sobivaid ronge ei leitud."
    exit 1
fi

# 8. Leia praegune kellaaeg
praegune_aeg=$(date +%H:%M)

echo ""
echo "$lahtejaam -> $sihtjaam"
echo "Praegune kellaaeg: $praegune_aeg"
echo ""
echo "Väljumised:"

# 9. & 10. Töötle väljumisaegu eraldi muutujate abil (ilma tsüklita)
aeg1=$(echo "$ajad" | sed -n '1p')
aeg2=$(echo "$ajad" | sed -n '2p')
aeg3=$(echo "$ajad" | sed -n '3p')
aeg4=$(echo "$ajad" | sed -n '4p')

# Kontroll ja väljastus 1. väljumisajale
if test -n "$aeg1"
then
    if [ "$aeg1" \< "$praegune_aeg" ]
    then
        echo -e "${PUNANE}$aeg1  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}$aeg1  rong on veel ees${RESET}"
    fi
fi

# Kontroll ja väljastus 2. väljumisajale
if test -n "$aeg2"
then
    if [ "$aeg2" \< "$praegune_aeg" ]
    then
        echo -e "${PUNANE}$aeg2  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}$aeg2  rong on veel ees${RESET}"
    fi
fi

# Kontroll ja väljastus 3. väljumisajale
if test -n "$aeg3"
then
    if [ "$aeg3" \< "$praegune_aeg" ]
    then
        echo -e "${PUNANE}$aeg3  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}$aeg3  rong on veel ees${RESET}"
    fi
fi

# Kontroll ja väljastus 4. väljumisajale
if test -n "$aeg4"
then
    if [ "$aeg4" \< "$praegune_aeg" ]
    then
        echo -e "${PUNANE}$aeg4  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}$aeg4  rong on veel ees${RESET}"
    fi
fi
