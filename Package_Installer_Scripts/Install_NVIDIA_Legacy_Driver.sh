#!/bin/bash
sudo pacman -Rns egl-gbm egl-wayland egl-wayland2 egl-x11 libva-nvidia-driver nvidia-open-dkms nvidia-utils
yay -S vulkan-icd-loader lib32-vulkan-icd-loader nvidia-580xx-utils lib32-nvidia-580xx-utils nvidia-580xx-settings nvidia-580xx-dkms libxnvctrl-580xx lib32-opencl-nvidia-580xx opencl-nvidia-580xx
echo "All Finished !!!"



