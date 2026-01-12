#!/bin/sh
sudo pacman -Syu
sudo pacman -S intel-graphics-compiler intel-compute-runtime mesa lib32-mesa vulkan-headers vulkan-validation-layers vulkan-tools libva-intel-driver libvdpau-va-gl libva-utils intel-ucode intel-media-driver linux-firmware directx-headers libva-mesa-driver lib32-libva-mesa-driver vulkan-mesa-layers lib32-vulkan-mesa-layers vulkan-driver lib32-vulkan-driver vulkan-mesa-implicit-layers lib32-vulkan-mesa-implicit-layers
echo "All Finished !!!"



