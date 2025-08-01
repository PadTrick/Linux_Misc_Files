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

sudo pacman -S git curl

clear
echo -e "Choose your packages to install \n"
#GPU Drivers
echo -e "Which Hyprland Dot Files should be installed ?"
PS1='Select: '
opt1=("JaKooLit" "end_4" "HyDE")
select opt1 in "${opt1[@]}"
do
    case $opt1 in
        "JaKooLit")
            echo "you choose JaKooLit"
            DOT_FILES="JaKooLit"
            break
            ;;
        "end_4")
            echo "you choose end_4"
            DOT_FILES="end_4"
            break
            ;;
        "HyDE")
            echo "you choose HyDE"
            DOT_FILES="HyDE"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear

if [ "$DOT_FILES" == "JaKooLit" ]; then
    echo "Installing JaKooLit Dot Files"
    git clone --depth=1 https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland
    cd ~/Arch-Hyprland
    chmod +x install.sh
    ./install.sh
fi

if [ "$DOT_FILES" == "end_4" ]; then
    echo "Installing end_4 Dot Files"
    bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")
fi

if [ "$DOT_FILES" == "HyDE" ]; then
    echo "Installing HyDE Dot Files"
    sudo pacman -S --needed git base-devel
    git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE
    cd ~/HyDE/Scripts
    ./install.sh
fi


