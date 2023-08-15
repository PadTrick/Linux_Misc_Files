#!/bin/bash
WORKING_DIR=$(pwd)
clear
echo "creating dir $HOME/git and cloning all packages into it"
mkdir $HOME/git
cd $HOME/git
echo "Installing AUR packages"
echo "git clone kded-rotation-git"
git clone https://aur.archlinux.org/kded-rotation-git.git
echo "Installing kded-rotation-git"
cd kded-rotation-git && makepkg -si
cd $HOME/git
echo "kded-rotation-git installed !!!"

echo "Installing AUR packages"
echo "git clone kded-rotation-git"
git clone https://aur.archlinux.org/corekeyboard.git
echo "Installing corekeyboard.git"
cd corekeyboard && makepkg -si
cd $HOME/git
echo "corekeyboard.git installed !!!"

echo "All installations finished !!!"
