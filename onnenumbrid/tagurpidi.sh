#!/bin/bash

# Loeb iseenda faili ($0), pöörab ridade järjekorra (tac) ja iga rea tähed tagurpidi (rev)
cat "$0" | tac | rev
