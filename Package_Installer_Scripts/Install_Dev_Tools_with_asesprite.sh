#!/bin/bash
clear
echo "Installing Dev Tools"

sudo pacman -Syyu
sudo pacman -S godot krita blender gimp cmake github-cli dotnet-runtime dotnet-sdk dotnet-targeting-pack dotnet-targeting-pack-6.0 dotnet-host aspnet-runtime mono android-udev mono-msbuild mono-msbuild-sdkresolver --noconfirm

yay -Syyu
yay -S github-desktop-bin gnome-keyring visual-studio-code-bin mono-basic android-sdk android-sdk-cmdline-tools-latest android-sdk-build-tools android-sdk-platform-tools android-sdk-cmake android-platform android-ndk ncurses5-compat-libs pycharm-community-jre laigter rider rustrover webstorm material-maker-bin aseprite --noconfirm

dotnet new install "MonoGame.Templates.CSharp"
dotnet new install "Avalonia.Templates"

echo "See https://github.com/dotnet/templating/wiki/Available-templates-for-dotnet-new for more"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

. "$HOME/.cargo/env"

rustup target add x86_64-unknown-linux-gnu
rustup target add i686-unknown-linux-gnu


echo "Installation finished. Please reboot now !!!"
echo "======================================================"
echo "To fix runtime errors with RustRover,WebStorm and Aqua"
echo "goto /opt/appname and start the app at the welcome screen"
echo "press CTRL+SHIFT+A and type >Choose Boot Java Runtime for the IDE ...<"
echo "Select default and press >OK<, now it should work."
echo "======================================================"
