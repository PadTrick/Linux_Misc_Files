#!/bin/sh
mkdir $HOME/git && cd $HOME/git
git clone https://github.com/Frogging-Family/mesa-git.git
cd mesa-git
makepkg -si
echo "All finished"
