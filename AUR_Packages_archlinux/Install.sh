#!/bin/bash
WORKING_DIR=$(pwd)
clear
echo -e "Setting up Chaotix AUR \n"
#enable Chaotix AUR ?
echo -e "Add Chaotix AUR to your mirrorlist ?"
PS1='Select: '
opt1=("Yes" "No")
select opt1 in "${opt1[@]}"
do
    case $opt1 in
        "Yes")
            echo "you choose Yes"
            ADD_CHAOTIX="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            ADD_CHAOTIX="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#XBOX Drivers
echo -e "Install Xbox One Wireless Gamepad Driver ?"
PS2='Select: '
opt2=("Yes" "No")
select opt2 in "${opt2[@]}"
do
    case $opt2 in
        "Yes")
            echo "you choose Yes"
            XBOX_DRIVER="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            XBOX_DRIVER="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#JP Fonts
echo -e "Install ttf-kochi-substitute - JP Font ?"
PS3='Select: '
opt3=("Yes" "No")
select opt3 in "${opt3[@]}"
do
    case $opt3 in
        "Yes")
            echo "you choose Yes"
            JP_FONT="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            JP_FONT="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#FIRMWARE
echo -e "Install ast, aic94xx & wd719x firmware ?"
PS4='Select: '
opt4=("Yes" "No")
select opt4 in "${opt4[@]}"
do
    case $opt4 in
        "Yes")
            echo "you choose Yes"
            INSTALL_FIRMWARE="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_FIRMWARE="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Gamescope
echo -e "Install Gamescope-Plus ?"
PS5='Select: '
opt5=("Yes" "No")
select opt5 in "${opt5[@]}"
do
    case $opt5 in
        "Yes")
            echo "you choose Yes"
            INSTALL_GAMESCOPE="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_GAMESCOPE="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#NVIDIA Drivers
echo -e "Install NVIDIA 525.xx Drivers ?"
PS6='Select: '
opt6=("Yes" "No")
select opt6 in "${opt6[@]}"
do
    case $opt6 in
        "Yes")
            echo "you choose Yes"
            NVIDIA_DRIVERS="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            NVIDIA_DRIVERS="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Visual Studio Code
echo -e "Install Visual Studio Code ?"
PS6='Select: '
opt6=("Yes" "No")
select opt6 in "${opt6[@]}"
do
    case $opt6 in
        "Yes")
            echo "you choose Yes"
            INSTALL_VSC="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_VSC="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#OBS Studio Git
echo -e "Install OBS Studio Git ?"
PS6='Select: '
opt6=("Yes" "No")
select opt6 in "${opt6[@]}"
do
    case $opt6 in
        "Yes")
            echo "you choose Yes"
            INSTALL_OBS="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_OBS="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

#summary
clear
echo "Chaotix AUR = $ADD_CHAOTIX | XBox Driver = $XBOX_DRIVER | JP Fonts = $JP_FONT | Firmware = $INSTALL_FIRMWARE | Gamescope Plus = $INSTALL_GAMESCOPE | NVIDIA 525.xx Drivers = $NVIDIA_DRIVERS | Visual Studio Code = $INSTALL_VSC | OBS Studio Git = $INSTALL_OBS"
echo ""
PS8='Select: '
opt8=("Continue")
select opt8 in "${opt8[@]}"
do
    case $opt8 in
        "Continue")
            echo "you choose Continue"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "Installing ..."

if [ "$ADD_CHAOTIX" == "Yes" ]; then
    echo "Adding Chaotix AUR to mirrorlist"
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    echo ' ' | sudo tee -a /etc/pacman.conf >/dev/null
    echo '[chaotic-aur]' | sudo tee -a /etc/pacman.conf >/dev/null
    echo 'Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf >/dev/null
    echo ' ' | sudo tee -a /etc/pacman.conf >/dev/null
fi

sudo pacman -Syyu

if [ "$INSTALL_VSC" == "Yes" ]; then
    echo "Installing Visual Studio Code"
    sudo pacman -S visual-studio-code-bin
fi

if [ "$INSTALL_OBS" == "Yes" ]; then
    echo "Installing OBS Studio Git"
    sudo pacman -S obs-studio-git
fi

if [ "$XBOX_DRIVER" == "Yes" ]; then
    echo "Installing Xbox One Wireless Gamepad Drivers"
    echo "creating dir $HOME/git and cloning all packages into it"
    mkdir $HOME/git
    echo "copying xone-dkms-git to $HOME/git"
    cp -a $WORKING_DIR/xone-dkms-git $HOME/git
    cd $HOME/git
    echo "Installing xone-dkms-git"
    sudo pacman -S xone-dongle-firmware
    cd xone-dkms-git && makepkg -si
    cd $HOME/git
    echo "Xbox One Gamepad Driver installed !!!"
fi

if [ "$JP_FONT" == "Yes" ]; then
    echo "Installing ttf-kochi-substitute - JP Font"
    echo "creating dir $HOME/git and cloning all packages into it"
    mkdir $HOME/git
    cd $HOME/git
    echo "copying ttf-kochi-substitute to $HOME/git"
    cp -a $WORKING_DIR/ttf-kochi-substitute $HOME/git
    echo "Installing ttf-kochi-substitute"
    cd ttf-kochi-substitute && makepkg -si
    cd $HOME/git
    echo "ttf-kochi-substitute - JP Font installed !!!"
fi

if [ "$INSTALL_FIRMWARE" == "Yes" ]; then
    echo "Installing ast, aic94xx & wd719x Firmware "
    echo "creating dir $HOME/git and cloning all packages into it"
    mkdir $HOME/git
    cd $HOME/git
    echo "git clone https://aur.archlinux.org/ast-fw.git"
    git clone https://aur.archlinux.org/ast-fw.git
    echo "git clone https://aur.archlinux.org/aic94xx-firmware.git"
    git clone https://aur.archlinux.org/aic94xx-firmware.git
    echo "git clone https://aur.archlinux.org/wd719x-firmware.git"
    git clone https://aur.archlinux.org/wd719x-firmware.git
    echo "Installing AUR packages"
    cd $HOME/git
    cd ast-fw && makepkg -si
    cd $HOME/git
    cd aic94xx-firmware && makepkg -si
    cd $HOME/git
    cd wd719x-firmware && makepkg -si
    echo "All Firmwares are installed !!!"
fi

if [ "$INSTALL_GAMESCOPE" == "Yes" ]; then
    echo "Installing Gamescope-Plus"
    echo "creating dir $HOME/git and cloning all packages into it"
    mkdir $HOME/git
    cd $HOME/git
    echo "git clone https://aur.archlinux.org/gamescope-plus.git"
    git clone https://aur.archlinux.org/gamescope-plus.git
    echo "git clone https://aur.archlinux.org/lib32-gamescope-plus.git"
    git clone https://aur.archlinux.org/lib32-gamescope-plus.git
    cd $HOME/git
    cd gamescope-plus && makepkg -si
    cd $HOME/git
    cd lib32-gamescope-plus && makepkg -si
    echo "Gamescope installed !!!"
fi

if [ "$NVIDIA_DRIVERS" == "Yes" ]; then
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
    git clone https://aur.archlinux.org/nvidia-525xx-utils.git
    echo "git clone lib32-nvidia-525xx-utils"
    git clone https://aur.archlinux.org/lib32-nvidia-525xx-utils.git
    echo "git clone nvidia-525xx-settings.git"
    git clone https://aur.archlinux.org/nvidia-525xx-settings.git
    echo "Installing AUR and Custom packages"
    cd nvidia-525xx-utils && makepkg -si
    cd $HOME/git
    cd lib32-nvidia-525xx-utils && makepkg -si
    cd $HOME/git
    cd nvidia-525xx-settings && makepkg -si
    cd $HOME/git
    echo "Nvidia GPU Driver installed !!!"
fi

if [ "$INSTALLED_STEAM" == "Yes" ]; then
    echo "Reinstalling steam & protontricks-git"
    sudo pacman -S steam protontricks-git
    echo "steam & protontricks-git reinstalled !!!"
fi

sudo pacman -Syyu
sudo pacman -S downgrade protontricks-git protonup-qt yay cpupower-gui

echo "Installation finished. Please reboot now !!!"
