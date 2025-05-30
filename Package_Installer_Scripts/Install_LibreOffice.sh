#!/bin/bash
clear
echo "Installing LibreOffice"

sudo pacman -Syyu
sudo pacman -S libreoffice-still libreoffice-still-de hunspell-de --noconfirm

echo "Installation finished. Please reboot now !!!"
