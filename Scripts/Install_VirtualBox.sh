#!/bin/bash
clear
echo "Installing VirtualBox"

sudo pacman -Syyu
sudo pacman -S virtualbox virtualbox-host-dkms virtualbox-guest-iso --noconfirm

echo "Installation finished. Please reboot now !!!"
