# ~/.local/bin/solaar-init.sh


#!/bin/bash

# Start Solaar in background without window
solaar -w hide &

# wait, to let solaar load the settings (edit, if longer waittime is needed)
sleep 5

# Force mouse LED & DPI settings
solaar config "G203 LIGHTSYNC Gaming Mouse" led_control solaar
solaar config "G203 LIGHTSYNC Gaming Mouse" led_logo static cyan no
solaar config "G203 LIGHTSYNC Gaming Mouse" dpi 1600

# end solaar
pkill solaar


#Dont forget to edit Exec path

# ~/.config/autostart/
#
[Desktop Entry]
Type=Application
Exec=/home/padtrick/.local/bin/solaar-init.sh
Hidden=false
X-GNOME-Autostart-enabled=true
Name=Solaar Init
Comment=Starts Solaar to force the devicesettings
