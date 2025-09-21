#!/bin/bash

directory="."  # Aktuelles Verzeichnis

declare -A packages

echo "Verfügbare Pakete:"

i=1
while IFS= read -r line; do
    date=$(echo "$line" | awk '{print $(NF-3) " " $(NF-2) " " $(NF-1)}')
    filename=$(echo "$line" | awk '{print $NF}')
    if [[ "$filename" == mesa-tkg-git-*.pkg.tar.zst ]]; then
        shortname=$(echo "$filename" | sed -E 's/mesa-tkg-git-([0-9]+\.[0-9]+\.[0-9]+)\.[0-9]+\.[a-f0-9]+-.*\.pkg\.tar\.zst/mesa \1/' | sed -E 's/mesa-tkg-git-[^-]+_devel\.([0-9]+\.[a-f0-9]+)-.*\.pkg\.tar\.zst/mesa git \1/')
        packages[$i]="$filename"
        echo "$i) $shortname ($date)"
        ((i++))
    fi
done < <(ls -ltr --time-style=long-iso "$directory" | grep 'mesa-tkg-git-.*pkg.tar.zst')

if [[ ${#packages[@]} -eq 0 ]]; then
    echo "Keine passenden Pakete gefunden."
    exit 1
fi

echo -n "Wähle eine Nummer zum Installieren: "
read choice

selected_pkg=${packages[$choice]}
if [[ -z "$selected_pkg" ]]; then
    echo "Ungültige Auswahl."
    exit 1
fi

# Passendes lib32-Paket finden
lib32_pkg=$(echo "$selected_pkg" | sed 's/^mesa/lib32-mesa/')
if [[ ! -f "$lib32_pkg" ]]; then
    echo "Kein passendes lib32-Paket gefunden: $lib32_pkg"
    exit 1
fi

echo "Erzwinge Deinstallation der konfliktierenden Pakete..."
# Force remove der problematischen Pakete
sudo pacman -Rdd vulkan-mesa-device-select lib32-vulkan-mesa-device-select --noconfirm 2>/dev/null || true

# Lösche die konfliktierenden Dateien manuell falls nötig
sudo rm -f /usr/lib/libVkLayer_MESA_device_select.so 2>/dev/null || true
sudo rm -f /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json 2>/dev/null || true
sudo rm -f /usr/lib32/libVkLayer_MESA_device_select.so 2>/dev/null || true

# Installation beider Pakete
echo "Installiere mesa-tkg-git Pakete..."
sudo pacman -U "./$selected_pkg" "./$lib32_pkg"
sudo pacman -S opengl-man-pages --noconfirm

echo "Finished!!!"
