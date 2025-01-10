#!/bin/sh
mkdir $HOME/git && cd $HOME/git
echo "Downloading Mesa Minimal Git Packages"
git clone https://aur.archlinux.org/llvm-minimal-git.git
git clone https://aur.archlinux.org/spirv-headers-git.git
git clone https://aur.archlinux.org/spirv-llvm-translator-minimal-git.git
git clone https://aur.archlinux.org/libclc-minimal-git.git
git clone https://aur.archlinux.org/mesa-minimal-git.git
clear
echo "Downloading Lib32 Mesa Minimal Git Packages"
git clone https://aur.archlinux.org/lib32-llvm-minimal-git.git
git clone https://aur.archlinux.org/lib32-spirv-llvm-translator-minimal-git.git
git clone https://aur.archlinux.org/lib32-mesa-minimal-git.git
clear
echo "Building Mesa Minimal Git Packages"
cd $HOME/git/llvm-minimal-git && makepkg -si
cd $HOME/git/spirv-headers-git && makepkg -si
cd $HOME/git/spirv-llvm-translator-minimal-git && makepkg -si
cd $HOME/git/libclc-minimal-git && makepkg -si
cd $HOME/git/mesa-minimal-git && makepkg -si
echo "Building Lib32 Mesa Minimal Git Packages"
cd $HOME/git/lib32-llvm-minimal-git && makepkg -si
cd $HOME/git/lib32-spirv-llvm-translator-minimal-git && makepkg -si
cd $HOME/git/lib32-mesa-minimal-git && makepkg -si
echo "Finshed !!!"
