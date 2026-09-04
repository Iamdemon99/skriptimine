#!/bin/bash
# Skript väljastab tervituse koos sisselogitud kasutajanimega

echo -n "Tere, "
nimi=$(whoami)
echo -n "$nimi "
echo "!"
