#!/bin/bash
#
# reisi korraldamine
#

# inimeste andmed
echo -n "Sisesta reisijate arv: "
read reisijad

# kohtade andmed bussis
echo -n "Sisesta kohtade arv bussis: "
read kohad

# arvutused
bussid=$((reisijad / kohad))
ylejaanud=$((reisijad % kohad))

# kui on olemas ylejaanud, tuleb suurendada busside arv 1 võrra
if test $ylejaanud -gt 0
then
    bussid=$((bussid + 1))
fi

# tulemuste väljastamine
echo "Kokku on vaja $bussid bussi"
