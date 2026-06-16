#!/bin/bash

OUTPUT_FILE="$HOME/games.txt"

{
    find /home/padtrick/_SSD/SteamLibrary /home/padtrick/_SSD2/SteamLibrary -name "*.acf" -exec awk -F'"' '/"name"/ {print $4}' {} \; | \
    grep -vE "Proton|Steam Linux Runtime"

    find /home/padtrick/_SSD2/Games/heroic/games -mindepth 1 -maxdepth 1 -type d -exec basename {} \;

    find /home/padtrick/_SSD2/Games -mindepth 1 -maxdepth 1 -type d \
        ! -name "heroic" \
        ! -name "games" \
        ! -name "Games" \
        ! -name "ubisoft-connect" \
        -exec basename {} \;

} | sort -f > "$OUTPUT_FILE"
