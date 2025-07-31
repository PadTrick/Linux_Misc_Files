#!/bin/bash

# Install dependencies (with sudo check)
clear
echo -e "\e[1;33m=== Hyprland Dotfiles Installer ===\e[0m"
echo "Installation requires sudo rights. Please enter your password if prompted."
sudo pacman -S --needed git curl flatpak || { echo -e "\e[1;31m✗ Dependencies failed to install\e[0m"; exit 1; }

# Dotfiles selection
clear
echo -e "\e[1;36mChoose your Hyprland Dotfiles:\e[0m"
PS3='Select option: '
options=("ML4W" "JaKooLit" "end_4" "HyDE" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "ML4W")
            echo -e "\e[1;32m✓ Selected ML4W\e[0m"
            mkdir -p ~/Downloads
            curl -o ~/Downloads/hyprland-dotfiles-stable.dotinst \
                https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/hyprland-dotfiles-stable.dotinst \
                || { echo -e "\e[1;31m✗ Download failed\e[0m"; exit 1; }
            flatpak install -y flathub com.ml4w.dotfilesinstaller && \
                flatpak run com.ml4w.dotfilesinstaller
            break
            ;;
        "JaKooLit")
            echo -e "\e[1;32m✓ Selected JaKooLit\e[0m"
            git clone --depth=1 https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland || \
                { echo -e "\e[1;31m✗ Clone failed\e[0m"; exit 1; }
            cd ~/Arch-Hyprland && \
                [ ! -x install.sh ] && chmod +x install.sh
            ./install.sh
            break
            ;;
        "end_4")
            echo -e "\e[1;32m✓ Selected end_4\e[0m"
            bash <(curl -s https://end-4.github.io/dots-hyprland-wiki/setup.sh) || \
                { echo -e "\e[1;31m✗ Remote script failed\e[0m"; exit 1; }
            break
            ;;
        "HyDE")
            echo -e "\e[1;32m✓ Selected HyDE\e[0m"
            sudo pacman -S --needed git base-devel || \
                { echo -e "\e[1;31m✗ Dependencies failed\e[0m"; exit 1; }
            git clone --depth=1 https://github.com/HyDE-Project/HyDE ~/HyDE || \
                { echo -e "\e[1;31m✗ Clone failed\e[0m"; exit 1; }
            cd ~/HyDE/Scripts && \
                [ ! -x install.sh ] && chmod +x install.sh
            ./install.sh
            break
            ;;
        "Quit")
            echo -e "\e[1;33mInstallation canceled\e[0m"
            exit 0
            ;;
        *) echo -e "\e[1;31m✗ Invalid option $REPLY\e[0m";;
    esac
done

echo -e "\e[1;32m✓ Installation completed!\e[0m"