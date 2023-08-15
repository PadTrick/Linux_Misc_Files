#!/bin/sh
WORKING_DIR=$(pwd)
sudo mkdir /usr/local/share/fonts
sudo mkdir /usr/local/share/fonts/otf
sudo mkdir /usr/local/share/fonts/ttf
sudo cp -r $WORKING_DIR/otf /usr/local/share/fonts
sudo cp -r $WORKING_DIR/ttf /usr/local/share/fonts
echo "Fonts have been installed !!!"
