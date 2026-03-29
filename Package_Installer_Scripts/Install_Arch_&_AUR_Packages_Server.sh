#!/bin/bash
WORKING_DIR=$(pwd)
sudo cp /etc/pacman.conf /etc/pacman.conf.bak
sudo sed -i 's/^#Color$/Color/' /etc/pacman.conf
if ! grep -q "^ILoveCandy" /etc/pacman.conf; then
    sudo sed -i '/^Color$/a ILoveCandy' /etc/pacman.conf
fi
sudo sed -i 's/^#ParallelDownloads = 5$/ParallelDownloads = 5/' /etc/pacman.conf
sudo sed -i 's/^#\[multilib\]$/\[multilib\]/' /etc/pacman.conf
sudo sed -i '/^\[multilib\]$/{n;s/^#Include = \/etc\/pacman.d\/mirrorlist$/Include = \/etc\/pacman.d\/mirrorlist/}' /etc/pacman.conf

sudo pacman -Syu
clear
echo -e "Setting keymap \n"
sudo localectl --no-convert set-keymap de-latin1-nodeadkeys
sudo localectl --no-convert set-x11-keymap de pc105 deadgraveacute

#Disabling build for debug packages
[ ! -f /etc/makepkg.conf.bak ] && sudo cp /etc/makepkg.conf /etc/makepkg.conf.bak

if ! grep -q '^#DEBUG_CFLAGS="-g"' /etc/makepkg.conf; then
    sudo sed -i 's/^DEBUG_CFLAGS="-g"/#DEBUG_CFLAGS="-g"/' /etc/makepkg.conf
fi

if ! grep -q '^#DEBUG_CXXFLAGS="\$DEBUG_CFLAGS"' /etc/makepkg.conf; then
    sudo sed -i 's/^DEBUG_CXXFLAGS="\$DEBUG_CFLAGS"/#DEBUG_CXXFLAGS="$DEBUG_CFLAGS"/' /etc/makepkg.conf
fi

if grep -q 'OPTIONS=.*[^!]debug' /etc/makepkg.conf; then
    sudo sed -i 's/OPTIONS=(\(.*\)debug\(.*\))/OPTIONS=(\1!debug\2)/' /etc/makepkg.conf
fi

clear
echo "Installing ..."

#Install tools to check fastest Mirrors
#Check Mirrors of France & Germany, select fastest 5 of these and write them into the mirrorlist
#currently disabled
sudo pacman -S reflector pacman-contrib --noconfirm
#sudo reflector --save /etc/pacman.d/mirrorlist --sort rate --country Germany --protocol https --latest 10

sudo pacman -Syu

#installing yay
sudo pacman -S git fakeroot go

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

#Discover missing dependencies
sudo pacman -S flatpak fwupd --noconfirm

#Installing Fonts
#WORKING_DIR=$(pwd)
sudo mkdir /usr/local/share/fonts
sudo mkdir /usr/local/share/fonts/otf
sudo mkdir /usr/local/share/fonts/ttf
sudo cp -r $WORKING_DIR/otf /usr/local/share/fonts
sudo cp -r $WORKING_DIR/ttf /usr/local/share/fonts

sudo pacman -S noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-dejavu ttf-liberation ttf-opensans --noconfirm

echo "Installing INTEL Drivers"
sudo pacman -S intel-graphics-compiler intel-compute-runtime mesa lib32-mesa vulkan-headers vulkan-validation-layers vulkan-tools libva-intel-driver libvdpau-va-gl libva-utils intel-ucode intel-media-driver linux-firmware directx-headers libva-mesa-driver lib32-libva-mesa-driver vulkan-mesa-layers lib32-vulkan-mesa-layers vulkan-driver lib32-vulkan-driver vulkan-mesa-implicit-layers lib32-vulkan-mesa-implicit-layers


#Some missing firmware packages
sudo pacman -S linux-firmware-qlogic --noconfirm

#Some libs & tools which will be usefull for extracting several archive formats, installing packages from AUR or mounting NTFS drivers, screenshots etc
sudo pacman -S gnome-keyring dkms linux-lts-headers linux-zen-headers cabextract curl glib2 gnome-desktop gtk3 mesa-utils unrar p7zip  psmisc  python-dbus python-distro python-evdev python-gobject python-lxml python-pillow python-pip python-lxml python-virtualenv fuse2 gawk polkit-kde-agent jre17-openjdk partitionmanager fastfetch gwenview kcalc qt5-imageformats qt6-imageformats btop nvtop vi less exfatprogs dosfstools --noconfirm

#utility to manage cpu frequency etc.
sudo pacman -S cpupower --noconfirm

#changing governor to ondemand
[ ! -f /etc/default/cpupower-service.conf.bak ] && sudo cp /etc/default/cpupower-service.conf /etc/default/cpupower-service.conf.bak

if grep -q "^#governor='ondemand'" /etc/default/cpupower-service.conf; then
    sudo sed -i "s/^#governor='ondemand'/governor='ondemand'/" /etc/default/cpupower-service.conf
fi


sudo pacman -S fmt lib32-sdl2 lib32-sdl2_image lib32-sdl2_mixer lib32-sdl2_ttf sdl2 sdl2_image sdl2_mixer sdl2_ttf --noconfirm


clear

echo "Installing AUR Packages..."

sudo pacman -Syu
yay -Syyu

echo "Installing ttf-kochi-substitute - JP Font"
echo "creating dir $HOME/git and cloning all packages into it"
mkdir $HOME/git
cd $HOME/git
echo "copying ttf-kochi-substitute to $HOME/git"
cp -a $WORKING_DIR/ttf-kochi-substitute $HOME/git
echo "Installing ttf-kochi-substitute"
cd ttf-kochi-substitute && makepkg -si
cd $HOME/git

echo "Installing ast, aic94xx, wd719x & upd72020x-fw Firmware "
yay -S ast-fw aic94xx-firmware wd719x-firmware upd72020x-fw --noconfirm
echo "All Firmwares are installed !!!"


yay -Syyu
yay -S downgrade python311 --noconfirm


echo "Installation finished. Please reboot now !!!"

