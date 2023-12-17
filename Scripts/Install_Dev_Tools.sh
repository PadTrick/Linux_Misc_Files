#!/bin/bash
clear
echo "Installing Dev Tools"

sudo pacman -Syyu
sudo pacman -S krita blender gimp cmake github-cli dotnet-runtime dotnet-sdk dotnet-targeting-pack dotnet-targeting-pack-6.0 dotnet-host aspnet-runtime mono android-udev mono-msbuild mono-msbuild-sdkresolver

yay -Syyu
yay -S rider godot-mono-bin github-desktop-bin visual-studio-code-bin mono-basic android-sdk android-sdk-cmdline-tools-latest android-sdk-build-tools android-sdk-platform-tools android-sdk-cmake android-platform android-ndk xamarin-android ncurses5-compat-libs aseprite-git

dotnet new install "MonoGame.Templates.CSharp"

echo "Installation finished. Please reboot now !!!"
