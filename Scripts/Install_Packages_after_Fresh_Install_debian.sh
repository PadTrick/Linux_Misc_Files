#!/bin/bash
clear
echo -e "Choose your packages to install \n"
#GPU Drivers
echo -e "Install NVIDIA Drivers ?"
PS1='Select: '
opt1=("Yes" "No")
select opt1 in "${opt1[@]}"
do
    case $opt1 in
        "Yes")
            echo "you choose Yes"
            NVIDIA_DRIVER="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            NVIDIA_DRIVER="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Filezilla
echo -e "Install OBS-Studio ?"
PS2='Select: '
opt2=("Yes" "No")
select opt2 in "${opt2[@]}"
do
    case $opt2 in
        "Yes")
            echo "you choose Yes"
            OBS_PACKAGE="Yes"
            break
            ;;
        "No")
            echo "you choose No"
            OBS_PACKAGE="No"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#Barrier
echo -e "Install Barrier ?"
PS3='Select: '
opt3=("Yes" "No")
select opt3 in "${opt3[@]}"
do
    case $opt3 in
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
echo "GPU = $NVIDIA_DRIVER | OBS-Studio = $OBS_PACKAGE | Barrier = $BARRIER_PACKAGE"
echo ""
PS4='Select: '
opt4=("Continue")
select opt4 in "${opt4[@]}"
do
    case $opt4 in
        "Continue")
            echo "you choose Continue"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "Installing ..."

#32bit support
sudo apt update
sudo dpkg --add-architecture i386

if [ "$NVIDIA_DRIVER" == "Yes" ]; then
    echo "Add "contrib", "non-free" and "non-free-firmware" components to /etc/apt/sources.list, for example:"
    echo "# Debian Bookworm"
    echo "deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware"
    echo ""
    echo "Continue after you modified your sources.list "
    echo ""
    PS4='Select: '
    opt4=("Continue")
    select opt4 in "${opt4[@]}"
    do
        case $opt4 in
            "Continue")
                echo "you choose Continue"
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    echo "Installing NVIDIA Drivers"
    sudo apt update
    sudo apt install nvidia-driver firmware-misc-nonfree
fi

#Some usefull packages
sudo apt update
sudo apt install btrfs-progs unrar sudo libvulkan1 libvulkan1:i386

#Opera
    echo "Please run the following command as ROOT ( su - ) and continue:"
    echo "wget -O - https://deb.opera.com/archive.key | apt-key add -"
    echo ""
    PS4='Select: '
    opt4=("Continue")
    select opt4 in "${opt4[@]}"
    do
        case $opt4 in
            "Continue")
                echo "you choose Continue"
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done

echo 'deb http://deb.opera.com/opera-stable/ stable non-free' | sudo tee -a /etc/apt/sources.list >/dev/null
sudo apt update
sudo apt install opera-stable

#Wine
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
sudo apt-get update
sudo apt-get install winehq-staging
sudo apt-get install winetricks

if [ "$OBS_PACKAGE" == "Yes" ]; then
    echo "Installing OBS-Studio"
    sudo apt install obs-studio
fi

if [ "$BARRIER_PACKAGE" == "Yes" ]; then
    echo "Installing Barrier"
    sudo apt install barrier
fi

echo "Installation finished. Please reboot now !!!"
