#!/bin/sh
WORKING_DIR=$(pwd)
sudo mkdir /usr/local/share/fonts
sudo mkdir /usr/local/share/fonts/otf
sudo mkdir /usr/local/share/fonts/ttf
sudo cp -r $WORKING_DIR/otf /usr/local/share/fonts
sudo cp -r $WORKING_DIR/ttf /usr/local/share/fonts


pacman -S noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-dejavu ttf-liberation ttf-opensans
echo "Fonts have been installed !!!"
