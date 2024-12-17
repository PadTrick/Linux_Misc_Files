#!/bin/bash
clear
echo "Installing LibreOffice"

sudo pacman -Syyu
sudo pacman -S libreoffice-still libreoffice-still-de --noconfirm

echo "Installation finished. Please reboot now !!!"
