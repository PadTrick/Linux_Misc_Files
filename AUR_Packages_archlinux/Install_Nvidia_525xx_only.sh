#!/bin/bash
clear
sudo pacman -Syyu
yay -Syyu
clear
#Steam?
echo -e "Is Steam installed ?"
PS9='Select: '
opt9=("Yes" "No")
select opt9 in "${opt9[@]}"
do
    case $opt9 in
        "Yes")
            echo "you choose Yes"
            INSTALLED_STEAM="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALLED_STEAM="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

if [ "$INSTALLED_STEAM" == "Yes" ]; then
    clear
    echo "Uninstalling steam & protontricks-git"
    echo "This is neccessary to install the NVIDIA Drivers."
    echo "They will be reinstalled after the NVIDIA Drivers are installed !!!"
    sudo pacman -R protontricks
    sudo pacman -R protontricks-git
    sudo pacman -R vulkan-driver
    sudo pacman -R steam
    echo "steam & protontricks-git uninstalled !!!"
fi

echo "Uninstalling old Nvidia drivers"
sudo pacman -R nvidia-dkms nvidia-settings nvidia-utils lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia libxnvctrl
echo "Installing Nvidia GPU Driver 525.xx"
echo "creating dir $HOME/git and cloning all packages into it"
mkdir $HOME/git
cd $HOME/git
echo "git clone nvidia-525xx-utils"
rm -rf nvidia-525xx-utils
git clone https://aur.archlinux.org/nvidia-525xx-utils.git
echo "git clone lib32-nvidia-525xx-utils"
rm -rf lib32-nvidia-525xx-utils
git clone https://aur.archlinux.org/lib32-nvidia-525xx-utils.git
echo "git clone nvidia-525xx-settings.git"
rm -rf nvidia-525xx-settings
git clone https://aur.archlinux.org/nvidia-525xx-settings.git
echo "Installing AUR and Custom packages"
cd nvidia-525xx-utils && makepkg -si
cd $HOME/git
cd lib32-nvidia-525xx-utils && makepkg -si
cd $HOME/git
cd nvidia-525xx-settings && makepkg -si
cd $HOME/git
echo "Nvidia GPU Driver installed !!!"

if [ "$INSTALLED_STEAM" == "Yes" ]; then
    clear
    echo "Reinstalling steam & neccessary packages"
    sudo pacman -S steam vulkan-driver protontricks
    echo "steam & protontricks-git uninstalled !!!"
fi

echo "Installation finished. Please reboot now !!!"
