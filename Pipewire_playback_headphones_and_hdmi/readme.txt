#the following is for my devices, you need to modify it for your needs

#create the script

nano ~/.config/pipewire/elgato-audio-setup.sh

#paste the following inside the script
#user "pw-link -o" & "pw-link -i" to find your devices

#!/bin/bash
pw-link alsa_output.pci-0000_0a_00.4.analog-stereo:monitor_FL alsa_output.pci-0000_08_00.0.hdmi-stereo-extra2:playback_FL
pw-link alsa_output.pci-0000_0a_00.4.analog-stereo:monitor_FR alsa_output.pci-0000_08_00.0.hdmi-stereo-extra2:playback_FR

#make the script executable

chmod +x ~/.config/pipewire/elgato_audio_setup.sh


#create the service script

nano ~/.config/systemd/user/elgato-audio.service

#paste the following inside the script

[Unit]
Description=Setup Elgato Audio Routing
After=pipewire.service
Requires=pipewire.service

[Service]
ExecStart=/bin/bash -c "sleep 5; /home/padtrick/.config/pipewire/elgato_audio_setup.sh"
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=default.target

#reload systemd

systemctl --user daemon-reload

#activate the service

systemctl --user enable elgato-audio.service

#manually start the service

systemctl --user start elgato-audio.service
