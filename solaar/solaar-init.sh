#!/bin/bash

# Start Solaar in background without window
solaar -w hide &

# wait, to let solaar load the settings (edit, if longer waittime is needed)
sleep 5

# Force mouse LED & DPI settings
solaar config "G203 LIGHTSYNC Gaming Mouse" led_control solaar
solaar config "G203 LIGHTSYNC Gaming Mouse" led_logo static cyan no
solaar config "G203 LIGHTSYNC Gaming Mouse" dpi 1600

# Force keyboard LED
solaar config "G213 Prodigy Gaming Keyboard" led_control solaar
solaar config "G213 Prodigy Gaming Keyboard" leds_primary static cyan no

# end solaar
pkill solaar
