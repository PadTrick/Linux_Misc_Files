#!/bin/bash
clear
echo -e "Choose your packages to install \n"
# GPU Drivers
echo -e "Install NVIDIA Drivers?"
PS1='Select: '
opt1=("Yes" "No")
select opt1 in "${opt1[@]}"
do
    case $opt1 in
        "Yes")
            echo "You chose Yes"
            NVIDIA_DRIVER="Yes"
            break
            ;;
        "No")
            echo "You chose No"
            NVIDIA_DRIVER="No"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done
clear

# OBS-Studio
echo -e "Install OBS-Studio?"
PS2='Select: '
opt2=("Yes" "No")
select opt2 in "${opt2[@]}"
do
    case $opt2 in
        "Yes")
            echo "You chose Yes"
            OBS_PACKAGE="Yes"
            break
            ;;
        "No")
            echo "You chose No"
            OBS_PACKAGE="No"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done
clear

# Barrier
echo -e "Install Barrier?"
PS3='Select: '
opt3=("Yes" "No")
select opt3 in "${opt3[@]}"
do
    case $opt3 in
        "Yes")
            echo "You chose Yes"
            BARRIER_PACKAGE="Yes"
            break
            ;;
        "No")
            echo "You chose No"
            BARRIER_PACKAGE="No"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

# Wine
echo -e "Install Wine?"
PS3='Select: '
opt3=("Yes" "No")
select opt4 in "${opt4[@]}"
do
    case $opt4 in
        "Yes")
            echo "You chose Yes"
            WINE_PACKAGE="Yes"
            break
            ;;
        "No")
            echo "You chose No"
            WINE_PACKAGE="No"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

# Summary
clear
echo "GPU = $NVIDIA_DRIVER | OBS-Studio = $OBS_PACKAGE | Barrier = $BARRIER_PACKAGE | Wine = $WINE_PACKAGE"
echo ""
PS5='Select: '
opt5=("Continue")
select opt5 in "${opt5[@]}"
do
    case $opt4 in
        "Continue")
            echo "You chose Continue"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Installing ..."

# Check if the required components are in /etc/apt/sources.list, and update if necessary
if ! grep -q "contrib" /etc/apt/sources.list || ! grep -q "non-free" /etc/apt/sources.list; then
    echo "Adding 'contrib', 'non-free', and 'non-free-firmware' components to /etc/apt/sources.list"

    # Backup the original sources.list first
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

    # Add the required components to the sources.list
    sudo sed -i 's|deb http://deb.debian.org/debian/ bookworm main non-free-firmware|deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware|' /etc/apt/sources.list
    sudo sed -i 's|deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware|deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware|' /etc/apt/sources.list
    sudo sed -i 's|deb http://security.debian.org/debian-security bookworm-security main non-free-firmware|deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware|' /etc/apt/sources.list
    sudo sed -i 's|deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware|deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware|' /etc/apt/sources.list
    sudo sed -i 's|deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware|deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware|' /etc/apt/sources.list
    sudo sed -i 's|deb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware|deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware|' /etc/apt/sources.list
else
    echo "'contrib', 'non-free', and 'non-free-firmware' components are already present in /etc/apt/sources.list"
fi

# Update package list and enable 32-bit support
sudo apt update
sudo dpkg --add-architecture i386

# Install NVIDIA Drivers if selected
if [ "$NVIDIA_DRIVER" == "Yes" ]; then
    echo "Installing NVIDIA Drivers"
    sudo apt update
    sudo apt install -y nvidia-driver firmware-misc-nonfree
    # Verify if NVIDIA driver installation is successful
    if ! command -v nvidia-smi &> /dev/null
    then
        echo "NVIDIA driver installation failed!"
        exit 1
    else
        echo "NVIDIA driver installed successfully!"
    fi
fi

# Install some useful packages
echo "Installing useful packages"
sudo apt install -y btrfs-progs unrar sudo libvulkan1 libvulkan1:i386 pkexec

# Install OBS-Studio if selected
if [ "$OBS_PACKAGE" == "Yes" ]; then
    echo "Installing OBS-Studio"
    sudo apt install -y obs-studio
fi

# Install Barrier if selected
if [ "$BARRIER_PACKAGE" == "Yes" ]; then
    echo "Installing Barrier"
    sudo apt install -y barrier
fi

# Install Wine if selected
if [ "$WINE_PACKAGE" == "Yes" ]; then
    echo "Installing Wine"
    sudo mkdir -pm755 /etc/apt/keyrings
    sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
    sudo apt-get update
    sudo apt-get install -y winehq-staging
    sudo apt-get install -y winetricks
fi

# Final message and reboot prompt
echo "Installation finished. Please reboot your system to apply the changes!"
echo "You can restart your system now by running the following command:"
echo "sudo reboot"
