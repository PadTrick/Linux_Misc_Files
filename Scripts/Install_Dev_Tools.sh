#!/bin/bash
clear
echo "Installing Dev Tools"

sudo pacman -Syyu
sudo pacman -S krita blender gimp cmake github-cli dotnet-runtime dotnet-sdk aspnet-runtime mono android-udev mono-msbuild mono-msbuild-sdkresolver



yay -Syyu
yay -S rider godot-mono-bin github-desktop visual-studio-code-bin mono-basic android-sdk ncurses5-compat-libs


echo "Installation finished. Please reboot now !!!"
