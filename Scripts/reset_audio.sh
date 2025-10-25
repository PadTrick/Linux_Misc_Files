#!/bin/bash

echo "Setze Audio-Links zurück..."

# Existierende Links entfernen
pw-link -d alsa_output.pci-0000_0a_00.4.analog-stereo:monitor_FL alsa_output.pci-0000_08_00.0.hdmi-stereo-extra2:playback_FL 2>/dev/null
pw-link -d alsa_output.pci-0000_0a_00.4.analog-stereo:monitor_FR alsa_output.pci-0000_08_00.0.hdmi-stereo-extra2:playback_FR 2>/dev/null

# Kurz warten
sleep 1

# Neue Links erstellen
pw-link alsa_output.pci-0000_0a_00.4.analog-stereo:monitor_FL alsa_output.pci-0000_08_00.0.hdmi-stereo-extra2:playback_FL
pw-link alsa_output.pci-0000_0a_00.4.analog-stereo:monitor_FR alsa_output.pci-0000_08_00.0.hdmi-stereo-extra2:playback_FR

echo "Audio-Links neu erstellt!"
