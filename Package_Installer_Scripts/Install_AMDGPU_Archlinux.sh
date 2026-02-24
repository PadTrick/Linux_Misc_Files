#!/bin/sh
sudo pacman -S mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver --noconfirm
echo "AMD Driver installed. Plz reboot !!!"
