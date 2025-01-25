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
opt2=("Solaar" "Piper" "Piper_GIT" "None")
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
        "Piper_GIT")
            echo "you choose Piper_GIT"
            MOUSE_DRIVER="Piper_GIT"
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
#Wacom Drawing Tablet
echo -e "Install Wacom Drawing Tablet drivers ?"
PS4='Select: '
opt4=("Yes" "No")
select opt4 in "${opt4[@]}"
do
    case $opt4 in
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
PS5='Select: '
opt5=("Yes" "No")
select opt5 in "${opt5[@]}"
do
    case $opt5 in
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
PS6='Select: '
opt6=("Yes" "No")
select opt6 in "${opt6[@]}"
do
    case $opt6 in
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
clear
#XBOX Drivers
echo -e "Install Xbox One Wireless Gamepad Driver ?"
PS7='Select: '
opt7=("Yes" "No")
select opt7 in "${opt7[@]}"
do
    case $opt7 in
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
#Gamescope
echo -e "Install Gamescope-GIT ?"
PS8='Select: '
opt8=("Yes" "No")
select opt8 in "${opt8[@]}"
do
    case $opt8 in
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
#Wayland
echo -e "Install xwayland and xwaylandvideobridge ?"
PS9='Select: '
opt9=("Yes" "No")
select opt9 in "${opt9[@]}"
do
    case $opt9 in
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
clear
#DevTools
echo -e "Install DevTools ?"
PS10='Select: '
opt10=("Yes" "No")
select opt10 in "${opt10[@]}"
do
    case $opt10 in
        "Yes")
            echo "you choose Yes"
            INSTALL_DEVTOOLS="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_DEVTOOLS="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Emulators
echo -e "Install Emulators ?"
PS11='Select: '
opt11=("Yes" "No")
select opt11 in "${opt11[@]}"
do
    case $opt11 in
        "Yes")
            echo "you choose Yes"
            INSTALL_EMULATORS="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_EMULATORS="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#LibreOffice
echo -e "Install LibreOffice ?"
PS12='Select: '
opt12=("Yes" "No")
select opt12 in "${opt12[@]}"
do
    case $opt12 in
        "Yes")
            echo "you choose Yes"
            INSTALL_LIBREOFFICE="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_LIBREOFFICE="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#VirtualBox
echo -e "Install Virtual Box ?"
PS13='Select: '
opt13=("Yes" "No")
select opt13 in "${opt13[@]}"
do
    case $opt13 in
        "Yes")
            echo "you choose Yes"
            INSTALL_VIRTUALBOX="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            INSTALL_VIRTUALBOX="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#summary
clear
echo "GPU = $GPU_DRIVER | Mouse = $MOUSE_DRIVER | Audio = $AUDIO_DRIVER | Wacom Drivers = $WACOM_DRIVER | Filezilla = $FILEZILLA_PACKAGE | Barrier = $BARRIER_PACKAGE | XBox Driver = $XBOX_DRIVER | Gamescope Plus = $INSTALL_GAMESCOPE | XWayland = $INSTALL_XWAYLAND"
echo "DevTools = $INSTALL_DEVTOOLS | Emulators = $INSTALL_EMULATORS | LibreOffice = $INSTALL_LIBREOFFICE | VirtualBox = $INSTALL_VIRTUALBOX"
echo ""
PS10='Select: '
opt10=("Continue")
select opt10 in "${opt10[@]}"
do
    case $opt10 in
        "Continue")
            echo "you choose Continue"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear

echo "Installing ..."

#Install tools to check fastest Mirrors
sudo pacman -S reflector pacman-contrib --noconfirm
#Check Mirrors of Germany, select fastest 5 of these and write them into the mirrorlist
#currently disabled
#sudo reflector --save /etc/pacman.d/mirrorlist --country Germany --protocol https --latest 10

#Update mirrors
sudo pacman -Syu

#Discover missing dependencies
sudo pacman -S packagekit-qt5 flatpak fwupd --noconfirm

if [ "$GPU_DRIVER" == "NVIDIA" ]; then
    echo "Installing NVIDIA Drivers"
    sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader nvidia-utils lib32-nvidia-utils nvidia-settings lib32-opencl-nvidia opencl-nvidia --noconfirm
    sudo tee -a /etc/environment > /dev/null <<EOL

# The following commands are for NVIDIA GPUs like my old GTX 1070Ti etc.
__GL_SHADER_DISK_CACHE=1
__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
__GL_SHADER_DISK_CACHE_SIZE=100000000000
#__GL_SHADER_DISK_CACHE_PATH=/var/cache/shaders

# Enable threaded optimisation for OpenGL.
__GL_THREADED_OPTIMIZATION=1
EOL
fi

if [ "$GPU_DRIVER" == "AMD" ]; then
    echo "Installing AMD Drivers"
    sudo pacman -S mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau --noconfirm
    sudo tee -a /etc/environment > /dev/null <<EOL

# The following commands are for Mesa (AMD/Intel)
MESA_GLSL_CACHE=1
MESA_GLSL_CACHE_DISABLE_CLEANUP=1
MESA_GLSL_CACHE_MAX_SIZE=102400
MESA_GLSL_CACHE_DIR=/var/cache/shaders

# Optional: Threaded Rendering für OpenGL
mesa_glthread=true
EOL
fi

if [ "$GPU_DRIVER" == "INTEL" ]; then
    echo "Installing INTEL Drivers"
    sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver linux-firmware intel-graphics-compiler intel-compute-runtime vulkan-headers vulkan-validation-layers vulkan-tools libva-intel-driver libvdpau-va-gl libva-utils intel-ucode directx-headers mesa-vdpau lib32-mesa-vdpau libva-mesa-driver lib32-libva-mesa-driver vulkan-mesa-layers lib32-vulkan-mesa-layers lib32-opencl-clover-mesa opencl-clover-mesa --noconfirm
    sudo tee -a /etc/environment > /dev/null <<EOL

# The following commands are for Mesa (AMD/Intel)
MESA_GLSL_CACHE=1
MESA_GLSL_CACHE_DISABLE_CLEANUP=1
MESA_GLSL_CACHE_MAX_SIZE=102400
MESA_GLSL_CACHE_DIR=/var/cache/shaders

# Optional: Threaded Rendering für OpenGL
mesa_glthread=true
EOL    
fi

if [ "$GPU_DRIVER" == "Hyper-V" ]; then
    echo "Installing Hyper-V Drivers"
    sudo pacman -S xf86-video-fbdev --noconfirm
fi

#Some missing firmware packages
sudo pacman -S linux-firmware-qlogic

#Some libs & tools which will be usefull for extracting several archive formats, installing packages from AUR or mounting NTFS drivers, screenshots etc
sudo pacman -S gnome-keyring ntfs-3g dkms linux-lts-headers linux-zen-headers cabextract  curl  glib2  gnome-desktop  gtk3  mesa-utils  unrar p7zip  psmisc  python-dbus  python-distro  python-evdev  python-gobject  python-lxml  python-pillow python-pip python-lxml git fuse2 gawk polkit-kde-agent jre17-openjdk pavucontrol kwalletmanager partitionmanager fastfetch gwenview kcalc qt5-imageformats qt6-imageformats btop --noconfirm

#Screenshot utility for KDE
sudo pacman -S spectacle --noconfirm

#utility to manage cpu frequency etc.
sudo pacman -S cpupower --noconfirm

#media player
sudo pacman -S vlc --noconfirm

#browsers
sudo pacman -S firefox vivaldi --noconfirm

#gaming overlay
sudo pacman -S mangohud lib32-mangohud goverlay --noconfirm

#Wine and dependencies
sudo pacman -S wine-staging winetricks --noconfirm
sudo pacman -S giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox --noconfirm

#steam, lutris and gamemode
sudo pacman -S steam gamemode lib32-gamemode lutris --noconfirm

#Packages for Diablo 1 DevilutionX Port
sudo pacman -S fmt lib32-sdl2 lib32-sdl2_image lib32-sdl2_mixer lib32-sdl2_ttf sdl2 sdl2_image sdl2_mixer sdl2_ttf --noconfirm

#Installing YAY
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
echo "yay installed !!!"

#Update mirrors
yay -Syyu

if [ "$MOUSE_DRIVER" == "Solaar" ]; then
    echo "Installing Solaar Drivers"
    sudo pacman -S solaar --noconfirm
fi

if [ "$MOUSE_DRIVER" == "Piper" ]; then
    echo "Installing Piper Drivers"
    sudo pacman -S piper --noconfirm
fi

if [ "$MOUSE_DRIVER" == "Piper_GIT" ]; then
    echo "Installing Piper GIT Drivers"
    yay -S piper-git --noconfirm
fi

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

if [ "$INSTALL_XWAYLAND" == "Yes" ]; then
    echo "Installing xwayland and xwaylandvideobridge"
    yay -S xorg-xwayland xwaylandvideobridge --noconfirm
fi

if [ "$XBOX_DRIVER" == "Yes" ]; then
    echo "Installing Xbox One Wireless Gamepad Drivers"
    yay -S xone-dlundqvist-dkms-git --noconfirm
    echo "Xbox One Gamepad Driver installed !!!"
fi

if [ "$INSTALL_GAMESCOPE" == "Yes" ]; then
    echo "Installing Gamescope-Plus"
	yay -S gamescope-git --noconfirm
    echo "Gamescope installed !!!"
fi

#Installing all Fonts
echo "All Fonts"
echo "creating dir $HOME/git and cloning all packages into it"
mkdir $HOME/git
cd $HOME/git
echo "copying ttf-kochi-substitute to $HOME/git"
cp -a $WORKING_DIR/ttf-kochi-substitute $HOME/git
echo "Installing ttf-kochi-substitute"
cd ttf-kochi-substitute && makepkg -si
echo "ttf-kochi-substitute - JP Font installed !!!"

sudo mkdir /usr/local/share/fonts
sudo mkdir /usr/local/share/fonts/otf
sudo mkdir /usr/local/share/fonts/ttf
sudo cp -r $WORKING_DIR/otf /usr/local/share/fonts
sudo cp -r $WORKING_DIR/ttf /usr/local/share/fonts

sudo pacman -S noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-dejavu ttf-liberation ttf-opensans --noconfirm
echo "Fonts have been installed !!!"

yay -S downgrade protontricks-git protonup-qt heroic-games-launcher-bin vkbasalt lib32-vkbasalt openrgb-bin vesktop ast-fw aic94xx-firmware wd719x-firmware upd72020x-fw --noconfirm

if [ "$INSTALL_DEVTOOLS" == "Yes" ]; then
    echo "Installing DevTools"
    sudo pacman -Syyu
    sudo pacman -S godot krita blender gimp cmake github-cli dotnet-runtime dotnet-sdk dotnet-targeting-pack dotnet-targeting-pack-6.0 dotnet-host aspnet-runtime mono android-udev mono-msbuild mono-msbuild-sdkresolver --noconfirm
    yay -Syyu
    yay -S github-desktop-bin gnome-keyring visual-studio-code-bin mono-basic android-sdk android-sdk-cmdline-tools-latest android-sdk-build-tools android-sdk-platform-tools android-sdk-cmake android-platform android-ndk xamarin-android ncurses5-compat-libs pycharm-community-jre laigter rider aseprite-git --noconfirm
    dotnet new install "MonoGame.Templates.CSharp"
    dotnet new install "Avalonia.Templates"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "DevTools installed !!!"
fi

if [ "$INSTALL_EMULATORS" == "Yes" ]; then
    echo "Installing Emulators"
    yay -S desmume fceux melonds mgba-qt ryujinx snes9x-gtk mupen64plus duckstation-git ppsspp pcsx2-latest-bin rpcs3-bin fs-uae fs-uae-launcher
    echo "Emulators installed !!!"
fi

if [ "$INSTALL_LIBREOFFICE" == "Yes" ]; then
    echo "Installing LibreOffice"
    sudo pacman -S libreoffice-still libreoffice-still-de --noconfirm
    echo "LibreOffice installed !!!"
fi

if [ "$INSTALL_VIRTUALBOX" == "Yes" ]; then
    echo "Installing LibreOffice"
    sudo pacman -S virtualbox virtualbox-host-dkms virtualbox-guest-iso --noconfirm
    echo "VirtualBox installed !!!"
fi

#Configuring Pacman
sed -i '/Color/s/^#//g' /etc/pacman.conf
sed -i '/ParallelDownloads = 5/s/^#//g' /etc/pacman.conf
sed -i '/Color/a ILoveCandy' /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

#Configuring CPUPOWER
sudo sed -i 's/^#governor=.*/governor="ondemand"/' /etc/default/cpupower

echo "Installation finished. Please reboot now !!!"