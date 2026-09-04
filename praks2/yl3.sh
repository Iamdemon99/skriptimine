#!/bin/bash
# Skript väljastab kuupäeva, kellaaja ja kalendri ilma muutujaid kasutamata
#allalaadita ncal, et kalender töötaks
date +"Today is %A, %B %d, %Y"
date +"Time is %H:%M"
echo ""
date +"Calendar of %B %Y"
cal | tail -n +2
