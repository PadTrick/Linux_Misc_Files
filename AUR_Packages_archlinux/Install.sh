#!/bin/bash
WORKING_DIR=$(pwd)
#Yet another yogurt. Pacman wrapper and AUR helper.
echo "Installing yay"
echo "creating dir $HOME/git and cloning all packages into it"
mkdir $HOME/git
cd $HOME/git
echo "cloning yay to $HOME/git"
git clone https://aur.archlinux.org/yay.git
echo "Installing yay"
cd yay && makepkg -si
cd $HOME/git
echo "yay installed !!!"
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

clear
#Wayland
echo -e "Install xwayland and xwaylandvideobridge ?"
PS7='Select: '
opt7=("Yes" "No")
select opt7 in "${opt7[@]}"
do
    case $opt7 in
        "Yes")
            echo "you choose Yes"
            INSTALL_XWAYLAND="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_XWAYLAND="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


#summary
clear
echo "XBox Driver = $XBOX_DRIVER | JP Fonts = $JP_FONT | Firmware = $INSTALL_FIRMWARE | Gamescope Plus = $INSTALL_GAMESCOPE | Visual Studio Code = $INSTALL_VSC | OBS Studio Git = $INSTALL_OBS | XWayland = $INSTALL_XWAYLAND"
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

sudo pacman -Syu
yay -Syyu

if [ "$INSTALL_VSC" == "Yes" ]; then
    echo "Installing Visual Studio Code"
    yay -S visual-studio-code-bin --noconfirm
fi

if [ "$INSTALL_OBS" == "Yes" ]; then
    echo "Installing OBS Studio Git"
    yay -S obs-studio-git --noconfirm
fi

if [ "$INSTALL_XWAYLAND" == "Yes" ]; then
    echo "Installing xwayland and xwaylandvideobridge"
    yay -S xorg-xwayland xwaylandvideobridge --noconfirm
fi

if [ "$XBOX_DRIVER" == "Yes" ]; then
    echo "Installing Xbox One Wireless Gamepad Drivers"
    yay -S xone-dkms-git xone-dongle-firmware --noconfirm
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
    cd ttf-kochi-substitute && makepkg -si --noconfirm
    cd $HOME/git
    echo "ttf-kochi-substitute - JP Font installed !!!"
fi

if [ "$INSTALL_FIRMWARE" == "Yes" ]; then
    echo "Installing ast, aic94xx & wd719x Firmware "
	yay -S ast-fw aic94xx-firmware wd719x-firmware --noconfirm
    echo "All Firmwares are installed !!!"
fi

if [ "$INSTALL_GAMESCOPE" == "Yes" ]; then
    echo "Installing Gamescope-Plus"
	yay -S gamescope-plus lib32-gamescope-plus --noconfirm
    echo "Gamescope installed !!!"
fi

yay -Syyu
yay -S downgrade protontricks-git protonup-qt --noconfirm

echo "Installation finished. Please reboot now !!!"
