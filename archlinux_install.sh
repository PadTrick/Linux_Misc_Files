#!/usr/bin/env bash

echo "Please enter a hostname"
read HOSTNAME 

echo "Please enter your username"
read USER 

echo "Please enter your password"
read PASSWORD 

echo "Please choose Your Desktop Environment"
echo "1. Hyprland"
echo "2. KDE"
echo "3. GNOME"
echo "4. XFCE"
echo "5. NoDesktop"
read DESKTOP

echo "Please choose Your GPU"
echo "1. NVIDIA"
echo "2. AMD"
echo "3. INTEL"
echo "4. Hyper-V"
read GPU

echo "Please choose Your Audio Server"
echo "1. Pipewire"
echo "2. Pulseaudio"
read AUDIO

echo "----------------------------------------------"
echo "-- INSTALLING Arch Linux BASE on Main Drive --"
echo "----------------------------------------------"
pacstrap /mnt base base-devel --noconfirm --needed

# kernel
pacstrap /mnt linux-lts linux-zen linux-firmware linux-lts-headers linux-zen-headers --noconfirm --needed

echo "------------------------"
echo "-- Setup Dependencies --"
echo "------------------------"

pacstrap /mnt networkmanager network-manager-applet nano vim btrfs-progs intel-ucode curl git openssh htop wget iwd wireless_tools wpa_supplicant unzip smartmontools xdg-utils cpupower --noconfirm --needed

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

echo "-----------------------------"
echo "-- Bootloader Installation --"
echo "-----------------------------"
bootctl install --path /mnt/boot
echo "default arch-zen.conf" >> /mnt/boot/loader/loader.conf

cat <<EOF > /mnt/boot/loader/entries/arch-zen.conf
title Arch Linux ZEN
linux /vmlinuz-linux-zen
initrd /initramfs-linux-zen.img
options root=${ROOT} rw
EOF

cat <<EOF > /mnt/boot/loader/entries/arch-lts.conf
title Arch Linux LTS
linux /vmlinuz-linux-lts
initrd /initramfs-linux-lts.img
options root=${ROOT} rw
EOF

cat <<REALEND > /mnt/next.sh
useradd -m $USER
usermod -aG wheel,storage,power,audio $USER
echo $USER:$PASSWORD | chpasswd
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "-------------------------------------------------"
echo "Configuring CPUPower"
echo "-------------------------------------------------"
sed -i "/governor='ondemand'/s/^#//g" /etc/default/cpupower

echo "-------------------------------------------------"
echo "Configuring Pacman"
echo "-------------------------------------------------"
sed -i '/Color/s/^#//g' /etc/pacman.conf
sed -i '/ParallelDownloads = 5/s/^#//g' /etc/pacman.conf
sed -i '/Color/a ILoveCandy' /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

pacman -S reflector pacman-contrib --noconfirm --needed
reflector --save /etc/pacman.d/mirrorlist --country Germany --protocol https --latest 5
pacman -Sy

echo "-------------------------------------------------"
echo "Display and Audio Drivers"
echo "-------------------------------------------------"

#X11
pacman -S xorg xorg-server xorg-xinit --noconfirm --needed

#DESKTOP
pacman -S gwenview qt6-imageformats qt5-imageformats ark vlc filezilla firefox pavucontrol partitionmanager barrier --noconfirm --needed

#MISC
pacman -S git-lfs qt6-5compat qt6-declarative qt6-svg tar dkms gnome-keyring ntfs-3g ark cabextract curl glib2 gnome-desktop gtk3 mesa-utils unrar p7zip psmisc python-dbus python-distro python-evdev python-gobject python-lxml python-pillow python-pip python-lxml fuse2 gawk jre17-openjdk neofetch xf86-input-wacom libwacom usbutils wacomtablet --noconfirm --needed

systemctl enable NetworkManager

#DESKTOP ENVIRONMENT
if [[ $DESKTOP == '1' ]]
then 
    pacman -S polkit hyprland dunst kitty wofi xdg-desktop-portal-hyprland qt5-wayland qt6-wayland sway swaybg swaylock swayidle waybar dmenu brightnessctl grim slurp pavucontrol foot xorg-xwayland sddm --noconfirm --needed
    systemctl enable sddm
elif [[ $DESKTOP == '2' ]]
then
    pacman -S plasma plasma-meta plasma-workspace egl-wayland sddm konsole dolphin kate dkms paprefs polkit-kde-agent kwalletmanager spectacle --noconfirm --needed
    systemctl enable sddm    
elif [[ $DESKTOP == '3' ]]
then 
    pacman -S gnome gdm --noconfirm --needed
    systemctl enable gdm
elif [[ $DESKTOP == '4' ]]    
then
    pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter --noconfirm --needed
    systemctl enable lightdm
else
    echo "You have choosen to Install Desktop Yourself"
fi

echo "-------------------------------------------------"
echo "GPU Drivers"
echo "-------------------------------------------------"

#GPU DRIVER
if [[ $GPU == '1' ]]
then 
    pacman -S vulkan-icd-loader lib32-vulkan-icd-loader nvidia-utils lib32-nvidia-utils nvidia-settings lib32-opencl-nvidia opencl-nvidia --noconfirm --needed
elif [[ $GPU == '2' ]]
then
    pacman -S mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau --noconfirm --needed
elif [[ $GPU == '3' ]]
then
    pacman -S intel-graphics-compiler intel-compute-runtime mesa lib32-mesa vulkan-headers vulkan-validation-layers vulkan-tools libva-intel-driver libvdpau-va-gl libva-utils intel-ucode intel-media-driver linux-firmware directx-headers mesa-vdpau lib32-mesa-vdpau libva-mesa-driver lib32-libva-mesa-driver vulkan-mesa-layers lib32-vulkan-mesa-layers lib32-opencl-clover-mesa opencl-clover-mesa --noconfirm --needed
elif [[ $GPU == '4' ]]
then
    pacman -S xf86-video-fbdev --noconfirm --needed
else
    echo " No GPU CARD Selected, you have to install drivers manually !!!"
fi

echo "-------------------------------------------------"
echo "AUDIO Server"
echo "-------------------------------------------------"

#AUDIO Server
if [[ $AUDIO == '1' ]]
then 
    pacman -S pipewire pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire libpulse wireplumber --noconfirm --needed
elif [[ $AUDIO == '2' ]]
then
    pacman -S pulseaudio pulseaudio-alsa paprefs --noconfirm --needed
else
    echo " No Audio Server selected, you have to install manually !!!"
fi

echo "-------------------------------------------------"
echo "Additional Packages"
echo "-------------------------------------------------"
pacman -S gnome-keyring ntfs-3g dkms linux-headers linux-lts-headers linux-zen-headers cabextract curl glib2 gnome-desktop gtk3 mesa-utils unrar p7zip psmisc python-dbus python-distro python-evdev python-gobject python-lxml python-pillow python-pip python-lxml git fuse2 gawk jre17-openjdk pavucontrol partitionmanager neofetch vlc xf86-input-wacom libwacom usbutils wacomtablet filezilla barrier --noconfirm --needed

echo "-------------------------------------------------"
echo "Gaming Packages"
echo "-------------------------------------------------"
pacman -S wine-staging winetricks mangohud lib32-mangohud goverlay giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox steam gamemode lib32-gamemode lutris fmt lib32-sdl2 lib32-sdl2_image lib32-sdl2_mixer lib32-sdl2_ttf sdl2 sdl2_image sdl2_mixer sdl2_ttf --noconfirm --needed

echo "-------------------------------------------------"
echo "Setup Language to DE and set locale"
echo "-------------------------------------------------"
sed -i 's/^#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=de_DE.UTF-8" >> /etc/locale.conf
loadkeys de-latin1-nodeadkeys
echo KEYMAP=de-latin1-nodeadkeys >> /etc/vconsole.conf

mkdir /etc/X11/xorg.conf.d
cat <<EOF > /etc/X11/xorg.conf.d/00-keyboard.conf
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "de"
        Option "XkbModel" "pc105"
        Option "XkbVariant" "deadgraveacute"
EndSection
EOF

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

echo "${HOSTNAME}" > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1	localhost
::1			localhost
127.0.1.1	$HOSTNAME.localdomain	$HOSTNAME
EOF

#localectl --no-convert set-keymap de-latin1-nodeadkeys
#localectl --no-convert set-x11-keymap de pc105 deadgraveacute

sed -i 's/^#timeout 3/timeout 10/' /boot/loader/loader.conf

#start Hyprland setup if selected
if [[ $DESKTOP == '1' ]]
then
    cd /home/$USER
    curl https://raw.githubusercontent.com/PadTrick/archlinux_install/main/get_hyprland_install.sh -o install.sh
    chmod +x install.sh
    
    echo "-----------------------------------------------------------"
    echo "You have to finish your Hyprland installation after reboot."
    echo "Reboot, login, start kitty (or any other konsole) and type"
    echo "the following command: sh install.sh in your HOME directory."
    echo "-----------------------------------------------------------"
else
    echo "-------------------------------------------------"
    echo "Install Complete, You can reboot now"
    echo "-------------------------------------------------"
fi

REALEND

arch-chroot /mnt sh next.sh
rm /mnt/next.sh
