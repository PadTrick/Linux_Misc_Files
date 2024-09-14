#!/bin/sh
WORKING_DIR=$(pwd)
yay -R steam
yay -R lib32-opencl-clover-mesa
yay -R opencl-clover-mesa
mkdir $HOME/git && cd $HOME/git && cp -a $WORKING_DIR/mesa-git-Frogging-Family && cd $HOME/git && cd mesa-git-Frogging-Family && makepkg -si && cd $HOME/git && yay -S directx-headers-git intel-ucode-git intel-media-driver-git lib32-intel-media-driver libva-intel-driver-git libvdpau-va-gl lib32-libvdpau-va-gl libva-utils-git vulkan-headers-git vulkan-validation-layers-git intel-gmmlib-git && sudo pacman -S steam
echo "All Finished !!!"
