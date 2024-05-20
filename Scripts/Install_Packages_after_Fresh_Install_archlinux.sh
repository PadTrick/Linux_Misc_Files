#!/bin/bash
clear
echo -e "Setting keymap \n"
sudo localectl --no-convert set-keymap de-latin1-nodeadkeys
sudo localectl --no-convert set-x11-keymap de pc105 deadgraveacute

clear
echo -e "Choose your packages to install \n"
#GPU Drivers
echo -e "Which GPU Drivers ?"
PS1='Select: '
opt1=("NVIDIA" "AMD" "INTEL" "Hyper-V")
select opt1 in "${opt1[@]}"
do
    case $opt1 in
        "NVIDIA")
            echo "you choose NVIDIA"
            GPU_DRIVER="NVIDIA"
            break
            ;;
        "AMD")
            echo "you choose AMD"
            GPU_DRIVER="AMD"
            break
            ;;
        "INTEL")
            echo "you choose INTEL"
            GPU_DRIVER="INTEL"
            break
            ;;
        "Hyper-V")
            echo "you choose Hyper-V"
            GPU_DRIVER="Hyper-V"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Mouse Drivers
echo -e "Which Mouse Drivers ?"
PS2='Select: '
opt2=("Solaar" "Piper" "None")
select opt2 in "${opt2[@]}"
do
    case $opt2 in
        "Solaar")
            echo "you choose Solaar"
            MOUSE_DRIVER="Solaar"
            break
            ;;
        "Piper")
            echo "you choose Piper"
            MOUSE_DRIVER="Piper"
            break
            ;;
        "None")
            echo "you choose None"
            MOUSE_DRIVER="None"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Audio Drivers
echo -e "Which Audio Drivers ?"
PS3='Select: '
opt3=("Pulseaudio" "Pipewire")
select opt3 in "${opt3[@]}"
do
    case $opt3 in
        "Pulseaudio")
            echo "you choose Pulseaudio"
            AUDIO_DRIVER="Pulseaudio"
            break
            ;;
        "Pipewire")
            echo "you choose Pipewire"
            AUDIO_DRIVER="Pipewire"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Audio Network Streaming
echo -e "Install Pulseaudio Network Streaming packages ?"
PS4='Select: '
opt4=("Yes" "No")
select opt4 in "${opt4[@]}"
do
    case $opt4 in
        "Yes")
            echo "you choose Yes"
            PULSE_NETWORK="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            PULSE_NETWORK="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Wacom Drawing Tablet
echo -e "Install Wacom Drawing Tablet drivers ?"
PS5='Select: '
opt5=("Yes" "No")
select opt5 in "${opt5[@]}"
do
    case $opt5 in
        "Yes")
            echo "you choose Yes"
            WACOM_DRIVER="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            WACOM_DRIVER="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Filezilla
echo -e "Install Filezilla FTP Client ?"
PS6='Select: '
opt6=("Yes" "No")
select opt6 in "${opt6[@]}"
do
    case $opt6 in
        "Yes")
            echo "you choose Yes"
            FILEZILLA_PACKAGE="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            FILEZILLA_PACKAGE="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Barrier
echo -e "Install Barrier ?"
PS7='Select: '
opt7=("Yes" "No")
select opt7 in "${opt7[@]}"
do
    case $opt7 in
        "Yes")
            echo "you choose Yes"
            BARRIER_PACKAGE="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            BARRIER_PACKAGE="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

#summary
clear
echo "GPU = $GPU_DRIVER | Mouse = $MOUSE_DRIVER | Audio = $AUDIO_DRIVER | Audio Network Streaming = $PULSE_NETWORK | Wacom Drivers = $WACOM_DRIVER | Filezilla = $FILEZILLA_PACKAGE | Barrier = $BARRIER_PACKAGE"
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

#Install tools to check fastest Mirrors
#Check Mirrors of France & Germany, select fastest 5 of these and write them into the mirrorlist
sudo pacman -S reflector pacman-contrib --noconfirm
sudo reflector --save /etc/pacman.d/mirrorlist --country France,Germany --protocol https --latest 5

sudo pacman -Syu

#Discover missing dependencies
sudo pacman -S packagekit-qt5 flatpak fwupd --noconfirm

if [ "$GPU_DRIVER" == "NVIDIA" ]; then
    echo "Installing NVIDIA Drivers"
    sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader nvidia-utils lib32-nvidia-utils nvidia-settings lib32-opencl-nvidia opencl-nvidia --noconfirm
fi

if [ "$GPU_DRIVER" == "AMD" ]; then
    echo "Installing AMD Drivers"
    sudo pacman -S mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau --noconfirm
fi

if [ "$GPU_DRIVER" == "INTEL" ]; then
    echo "Installing INTEL Drivers"
    sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver linux-firmware --noconfirm
fi

if [ "$GPU_DRIVER" == "Hyper-V" ]; then
    echo "Installing Hyper-V Drivers"
    sudo pacman -S xf86-video-fbdev --noconfirm
fi


#Some libs & tools which will be usefull for extracting several archive formats, installing packages from AUR or mounting NTFS drivers, screenshots etc
sudo pacman -S gnome-keyring ntfs-3g dkms linux-headers linux-lts-headers linux-zen-headers cabextract  curl  glib2  gnome-desktop  gtk3  mesa-utils  unrar p7zip  psmisc  python-dbus  python-distro  python-evdev  python-gobject  python-lxml  python-pillow python-pip python-lxml git fuse2 gawk polkit-kde-agent jre17-openjdk pavucontrol kwalletmanager partitionmanager neofetch --noconfirm

#Screenshot utility for KDE
sudo pacman -S spectacle --noconfirm

#utility to manage cpu frequency etc.
sudo pacman -S cpupower --noconfirm

#media player
sudo pacman -S vlc --noconfirm

#browsers
sudo pacman -S firefox --noconfirm

sudo pacman -S mangohud lib32-mangohud goverlay --noconfirm

#Wine and dependencies
sudo pacman -S wine-staging winetricks --noconfirm
sudo pacman -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox --noconfirm

#steam, lutris and gamemode
sudo pacman -S steam gamemode lib32-gamemode lutris --noconfirm

#Packages for Diablo 1 DevilutionX Port
sudo pacman -S fmt lib32-sdl2 lib32-sdl2_image lib32-sdl2_mixer lib32-sdl2_ttf sdl2 sdl2_image sdl2_mixer sdl2_ttf --noconfirm

if [ "$MOUSE_DRIVER" == "Solaar" ]; then
    echo "Installing Solaar Drivers"
    sudo pacman -S solaar --noconfirm
fi

if [ "$MOUSE_DRIVER" == "Piper" ]; then
    echo "Installing Piper Drivers"
    sudo pacman -S piper --noconfirm
fi

if [ "$AUDIO_DRIVER" == "Pulseaudio" ]; then
    echo "Installing Pulseaudio Drivers"
    sudo pacman -S paprefs --noconfirm
fi

if [ "$AUDIO_DRIVER" == "Pipewire" ]; then
    echo "Installing Pipewire Drivers"
    sudo pacman -S qpwgraph wireplumber --noconfirm
fi

if [ "$PULSE_NETWORK" == "Yes" ]; then
    echo "Installing Pulseaudio Network Streaming packages"
    sudo pacman -S pulseaudio-rtp pulseaudio-zeroconf --noconfirm
fi

if [ "$WACOM_DRIVER" == "Yes" ]; then
    echo "Installing Wacom Drawing Tablet drivers"
    sudo pacman -S xf86-input-wacom libwacom usbutils wacomtablet --noconfirm
fi

if [ "$FILEZILLA_PACKAGE" == "Yes" ]; then
    echo "Installing Filezilla FTP Client"
    sudo pacman -S filezilla --noconfirm
fi

if [ "$BARRIER_PACKAGE" == "Yes" ]; then
    echo "Installing Barrier"
    sudo pacman -S barrier --noconfirm
fi

echo "Installation finished. Please reboot now !!!"
