#!/bin/bash
find /home/padtrick/_SSD/SteamLibrary /home/padtrick/_SSD2/SteamLibrary -name "*.acf" -exec awk -F'"' '/"name"/ {print $4}' {} \; | sort >> ~/games_list.txt

find /home/padtrick/_SSD2/Games/Heroic/Games -maxdepth 1 -type d ! -path "/home/padtrick/_SSD2/Games/Heroic/Games" -exec basename {} \; | sort >> ~/games_list.txt
