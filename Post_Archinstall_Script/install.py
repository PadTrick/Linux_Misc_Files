import curses
import subprocess
import os

GPU_PACKAGES = {
    "NVIDIA": ["vulkan-icd-loader", "lib32-vulkan-icd-loader", "nvidia-utils", "lib32-nvidia-utils", "nvidia-settings", "lib32-opencl-nvidia", "opencl-nvidia"],
    "AMD": ["mesa", "lib32-mesa", "xf86-video-amdgpu", "vulkan-radeon", "lib32-vulkan-radeon", "amdvlk", "lib32-amdvlk", "libva-mesa-driver", "lib32-libva-mesa-driver", "mesa-vdpau", "lib32-mesa-vdpau"],
    "Intel": ["mesa", "lib32-mesa", "vulkan-intel", "lib32-vulkan-intel", "intel-media-driver", "linux-firmware", "intel-graphics-compiler", "intel-compute-runtime vulkan-headers", "vulkan-validation-layers", "vulkan-tools", "libva-intel-driver", "libvdpau-va-gl", "libva-utils", "intel-ucode", "directx-headers", "mesa-vdpau", "lib32-mesa-vdpau", "libva-mesa-driver", "lib32-libva-mesa-driver", "vulkan-mesa-layers", "lib32-vulkan-mesa-layers", "lib32-opencl-clover-mesa", "opencl-clover-mesa"],
    "Hyper-V": ["xf86-video-fbdev"]
}

AUDIO_PACKAGES = {
    "Pipewire": ["qpwgraph", "wireplumber"],
    "Puseaudio": ["paprefs"],
}

MOUSE_PACKAGES = {
    "Piper": ["piper"],
    "Piper-git": ["piper-git"],
    "Solaar": ["solaar"],
}

OTHER_PACKAGES = {
    "Wacom-Tablet": ["xf86-input-wacom", "libwacom", "usbutils", "wacomtablet"],
    "Filezilla": ["filezilla"],
    "Barrier": ["barrier"],
    "XOne-Driver": ["xone-dlundqvist-dkms-git"],
    "Gamescope": ["gamescope"],
}

GRAPHIC_PACKAGES = {
    "Krita": ["krita"],
    "Blender": ["blender"],
    "Gimp": ["gimp"],
    "Laigter": ["laigter"],
    "Aseprite": ["aseprite-git"],
}

DEV_PACKAGES = {
    "Godot": ["godot"],
    "VSCode": ["visual-studio-code-bin"],
    "Rider": ["rider"],
    "PyCharm_Community": ["pycharm-community-jre"],
    "Github_Desktop": ["github-desktop-bin", "gnome-keyring"],
}

# Unabhängige Pakete, die immer installiert werden
BASE_PACKAGES = ["reflector", "pacman-contrib", "packagekit-qt5", "flatpak", "fwupd", "linux-firmware-qlogic", "gnome-keyring", "ntfs-3g", "dkms", "linux-lts-headers", "linux-zen-headers", "cabextract", "curl", "glib2", "gnome-desktop", "gtk3", "mesa-utils", "unrar", "p7zip", "psmisc", "python-dbus", "python-distro", "python-evdev", "python-gobject", "python-lxml", "python-pillow", "python-pip", "python-lxml", "git", "fuse2", "gawk", "polkit-kde-agent", "jre17-openjdk", "pavucontrol", "kwalletmanager", "partitionmanager", "fastfetch", "gwenview", "kcalc", "qt5-imageformats", "qt6-imageformats", "btop", "vlc", "cpupower", "spectacle", "firefox", "vivaldi"]

# Unabhängige Pakete, die immer installiert werden
GAMING_PACKAGES = ["mangohud", "lib32-mangohud", "goverlay", "wine-staging", "winetricks", "giflib", "lib32-giflib", "libpng", "lib32-libpng", "libldap", "lib32-libldap", "gnutls", "lib32-gnutls", "mpg123", "lib32-mpg123", "openal", "lib32-openal", "v4l-utils", "lib32-v4l-utils", "libpulse", "lib32-libpulse", "alsa-plugins", "lib32-alsa-plugins", "alsa-lib", "lib32-alsa-lib", "libjpeg-turbo", "lib32-libjpeg-turbo", "libxcomposite", "lib32-libxcomposite", "libxinerama", "lib32-libxinerama", "ncurses", "lib32-ncurses", "opencl-icd-loader", "lib32-opencl-icd-loader", "libxslt", "lib32-libxslt", "libva", "lib32-libva", "gtk3", "lib32-gtk3", "gst-plugins-base-libs", "lib32-gst-plugins-base-libs", "vulkan-icd-loader", "lib32-vulkan-icd-loader", "cups", "samba", "dosbox", "steam", "gamemode", "lib32-gamemode", "lutris", "fmt", "lib32-sdl2", "lib32-sdl2_image", "lib32-sdl2_mixer", "lib32-sdl2_ttf", "sdl2", "sdl2_image", "sdl2_mixer", "sdl2_ttf"]

# AUR Pakete, die immer installiert werden, unabhängig von der Auswahl
AUR_BASE_PACKAGES = ["downgrade", "protontricks-git", "protonup-qt", "heroic-games-launcher-bin", "vkbasalt", "lib32-vkbasalt", "openrgb-bin", "vesktop", "xorg-xwayland", "xwaylandvideobridge", "ast-fw", "aic94xx-firmware", "wd719x-firmware", "upd72020x-fw"]

# DEV Pakete, die immer installiert werden, unabhängig von der Auswahl
DEV_BASE_PACKAGES = ["cmake", "github-cli"]

# Konfigurationsdaten für GPU Treiber in /etc/environment
GPU_ENV_CONFIG = {
    "NVIDIA": [
        "__GL_SHADER_DISK_CACHE=1",
        "__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1",
        "__GL_SHADER_DISK_CACHE_SIZE=100000000000",
        "#__GL_SHADER_DISK_CACHE_PATH=$HOME/.cache/shaders",
        "__GL_THREADED_OPTIMIZATION=1"
    ],
    "AMD": [
        "MESA_SHADER_CACHE_DISABLE=false",
        "MESA_SHADER_CACHE_MAX_SIZE=100G",
    ],
    "Intel": [
        "MESA_SHADER_CACHE_DISABLE=false",
        "MESA_SHADER_CACHE_MAX_SIZE=100G",
    ]
}

def install_rust():
    print("Installiere Rust...")
    # Rust mit curl installieren
    subprocess.run(["curl", "--proto", "=https", "--tlsv1.2", "-sSf", "https://sh.rustup.rs", "|", "sh"], shell=True)

def install_dotnet_templates():
    print("Installiere DotNet Templates...")
    # Installiere MonoGame und Avalonia Templates
    subprocess.run(["dotnet", "new", "install", "MonoGame.Templates.CSharp"])
    subprocess.run(["dotnet", "new", "install", "Avalonia.Templates"])

def install_yay():
    # Prüfe, ob yay bereits installiert ist
    if subprocess.run(["which", "yay"], capture_output=True).returncode != 0:
        print("yay wird installiert...")
        subprocess.run(["git", "clone", "https://aur.archlinux.org/yay.git"])
        subprocess.run(["cd", "yay", "&&", "makepkg", "-si"])

def install_fonts():
    working_dir = os.getcwd()

    # Erstelle die Verzeichnisse für die Fonts, falls sie noch nicht existieren
    print("Erstelle Verzeichnisse für die Fonts...")
    subprocess.run(["sudo", "mkdir", "-p", "/usr/local/share/fonts/otf"])
    subprocess.run(["sudo", "mkdir", "-p", "/usr/local/share/fonts/ttf"])

    # Kopiere die lokalen Fonts
    print("Kopiere lokale Fonts...")
    subprocess.run(["sudo", "cp", "-r", f"{working_dir}/otf", "/usr/local/share/fonts"])
    subprocess.run(["sudo", "cp", "-r", f"{working_dir}/ttf", "/usr/local/share/fonts"])

    # Installiere die Fonts aus den Repositories
    print("Installiere Fonts aus den Repositories...")
    subprocess.run(["yay", "-S", "noto-fonts", "noto-fonts-emoji", "noto-fonts-cjk", "ttf-dejavu", "ttf-liberation", "ttf-opensans", "--noconfirm"])

    # Installiere die Kochi Substitute Fonts aus dem lokalen PKGBUILD
    print("Installiere Kochi Substitute Fonts aus PKGBUILD...")
    subprocess.run(["makepkg", "-si", "-C", "--noconfirm"], cwd=f"{working_dir}/ttf-kochi-substitute")


def install_packages(packages):
    print("Installiere Pakete...")
    subprocess.run(["yay", "-S", "--noconfirm"] + packages)

def write_gpu_env_config(gpu_type):
    # Prüfe, ob GPU spezifische Konfiguration existiert
    if gpu_type in GPU_ENV_CONFIG:
        env_file = "/etc/environment"
        config_lines = GPU_ENV_CONFIG[gpu_type]

        # Leere die Datei, bevor neue Konfigurationen hinzugefügt werden
        with open(env_file, "w") as f:
            pass  # Diese Zeile leert die Datei

        # Schreibe die neuen GPU-Konfigurationen
        with open(env_file, "a") as f:
            f.write("\n" + "\n".join(config_lines) + "\n")

        print(f"GPU spezifische Konfiguration für {gpu_type} in {env_file} hinzugefügt.")

def draw_menu(stdscr, categories):
    curses.curs_set(0)
    selected = []
    current_category = 0
    current_option = 0
    in_category = False
    current_category_name = ""

    while True:
        stdscr.clear()
        height, width = stdscr.getmaxyx()

        stdscr.attron(curses.A_BOLD | curses.A_UNDERLINE)
        stdscr.addstr(0, 2, "Post Archinstall Script")  
        stdscr.attroff(curses.A_BOLD | curses.A_UNDERLINE)

        if in_category:
            stdscr.addstr(2, 2, f"Kategorie: {current_category_name}")

            options = categories[current_category]["options"]
            for i, option in enumerate(options):
                y = 4 + i
                if i == current_option:
                    stdscr.attron(curses.color_pair(1))
                    stdscr.addstr(y, 2, f"> {option['name']} {'[x]' if option.get('selected') else '[ ]'} <")
                    stdscr.attroff(curses.color_pair(1))
                else:
                    stdscr.addstr(y, 2, f"{option['name']} {'[x]' if option.get('selected') else '[ ]'}")

            back_y = 6 + len(options)
            if current_option == len(options):
                stdscr.attron(curses.color_pair(1))
                stdscr.addstr(back_y, 2, "<< Zurück")
                stdscr.attroff(curses.color_pair(1))
            else:
                stdscr.addstr(back_y, 2, "<< Zurück")

        else:
            for i, category in enumerate(categories):
                y = 3 + i * 2
                if i == current_category:
                    stdscr.attron(curses.color_pair(1))
                    stdscr.addstr(y, 2, f"> {category['name']} <")
                    stdscr.attroff(curses.color_pair(1))
                else:
                    stdscr.addstr(y, 2, category['name'])

            install_y = 5 + len(categories) * 2
            if current_category == len(categories):
                stdscr.attron(curses.color_pair(1))
                stdscr.addstr(install_y, 2, "> Installieren <")
                stdscr.attroff(curses.color_pair(1))
            else:
                stdscr.addstr(install_y, 2, "Installieren")

        stdscr.refresh()
        key = stdscr.getch()

        if not in_category:
            if key == curses.KEY_UP and current_category > 0:
                current_category -= 1
            elif key == curses.KEY_DOWN and current_category < len(categories):
                current_category += 1
            elif key == 10:
                if current_category == len(categories):  
                    return [opt['name'] for category in categories for opt in category["options"] if opt["selected"]]
                else:
                    in_category = True
                    current_category_name = categories[current_category]["name"]
                    current_option = 0
        else:
            options = categories[current_category]["options"]
            if key == curses.KEY_UP and current_option > 0:
                current_option -= 1
            elif key == curses.KEY_DOWN and current_option < len(options):  
                current_option += 1
            elif key == 32:
                options[current_option]["selected"] = not options[current_option]["selected"]
            elif key == 10:
                if current_option == len(options):
                    in_category = False
                else:
                    options[current_option]["selected"] = not options[current_option]["selected"]

        if key == ord('q'):
            return []

def main(stdscr):
    curses.start_color()
    curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_WHITE)
    curses.curs_set(0)

    categories = [
        {
            "name": "GPU Treiber",
            "options": [
                {"name": "NVIDIA", "selected": False},
                {"name": "AMD", "selected": False},
                {"name": "Intel", "selected": False},
                {"name": "Hyper-V", "selected": False},
            ]
        },
        {
            "name": "AUDIO Treiber",
            "options": [
                {"name": "Pipewire", "selected": False},
                {"name": "Puseaudio", "selected": False},
            ]
        },        
        {
            "name": "MAUS Treiber",
            "options": [
                {"name": "Piper", "selected": False},
                {"name": "Piper-git", "selected": False},
                {"name": "Solaar", "selected": False},
            ]
        },
        {
            "name": "Grafik & Design",
            "options": [
                {"name": "Krita", "selected": False},
                {"name": "Blender", "selected": False},
                {"name": "Gimp", "selected": False},
                {"name": "Laigter", "selected": False},
                {"name": "Aseprite", "selected": False},
            ]
        },      
        {
            "name": "DEV Tools & Engines",
            "options": [
                {"name": "Godot", "selected": False},
                {"name": "VSCode", "selected": False},
                {"name": "Rider", "selected": False},
                {"name": "PyCharm_Community", "selected": False},
                {"name": "Github_Desktop", "selected": False},
            ]
        },
        {
            "name": "Other Packages/Drivers",
            "options": [
                {"name": "Wacom-Tablet", "selected": False},
                {"name": "Filezilla", "selected": False},
                {"name": "Barrier", "selected": False},
                {"name": "XOne-Driver", "selected": False},
                {"name": "Gamescope", "selected": False},
            ]
        }        
    ]
    
    selected_packages = draw_menu(stdscr, categories)

    # Pakete sammeln
    final_packages = BASE_PACKAGES.copy()
    selected_gpu = None
    install_rust = False
    install_dotnet = False    
    for pkg in selected_packages:
        if pkg in GPU_PACKAGES:
            final_packages.extend(GPU_PACKAGES[pkg])
            selected_gpu = pkg  # Speichern des ausgewählten GPU-Treibers
        elif pkg in AUDIO_PACKAGES:
            final_packages.extend(AUDIO_PACKAGES[pkg])
        elif pkg in MOUSE_PACKAGES:
            final_packages.extend(MOUSE_PACKAGES[pkg])
        elif pkg in OTHER_PACKAGES:
            final_packages.extend(OTHER_PACKAGES[pkg])
        elif pkg in GRAPHIC_PACKAGES:
            final_packages.extend(GRAPHIC_PACKAGES[pkg])
        elif pkg in DEV_PACKAGES:
            final_packages.extend(DEV_PACKAGES[pkg])
        elif pkg in DEV_BASE_PACKAGES:
            final_packages.extend(DEV_BASE_PACKAGES[pkg])            
        elif pkg == "Rust":
            install_rust = True  # Markiere Rust zur Installation
        elif pkg == "Dot.Net":
            install_dotnet = True  # Markiere Dot.Net zur Installation
        else:
            final_packages.append(pkg)

    stdscr.clear()
    stdscr.addstr(0, 2, "Folgende Pakete werden installiert:")

    y = 2
    for pkg in final_packages:
        stdscr.addstr(y, 2, f"- {pkg}")
        y += 1

    stdscr.addstr(y + 1, 2, "Drücke ENTER, um fortzufahren...")
    stdscr.getch()

    # Installiere yay, falls noch nicht vorhanden
    install_yay()

    # Installiere Base Pakete
    print("Installiere Base Pakete...")
    install_packages(BASE_PACKAGES)

    # Installiere die GPU-Pakete zwischen BASE und GAMING
    if selected_gpu:
        print(f"Installiere {selected_gpu} Treiber...")
        install_packages(GPU_PACKAGES[selected_gpu])

    # Installiere Gaming Pakete
    print("Installiere Gaming Pakete...")
    install_packages(GAMING_PACKAGES)

    # Installiere alle ausgewählten Pakete
    print("Installiere ausgewählte Pakete...")
    install_packages(final_packages)

    # Installiere Rust, falls ausgewählt
    if install_rust:
        install_rust()  # Funktionsaufruf für Rust-Installation

    # Installiere Dot.Net, falls ausgewählt
    if install_dotnet:
        install_dotnet_templates()  # Funktionsaufruf für Dot.Net Templates

 # Installiere Fonts lokal und aus Repositories
    install_fonts()

    # Installiere AUR Base Pakete
    print("Installiere AUR Base Pakete...")
    install_packages(AUR_BASE_PACKAGES)

    # Schreibe GPU spezifische Konfigurationen in /etc/environment
    if selected_gpu:
        write_gpu_env_config(selected_gpu)

    print("\nFolgende Pakete wurden erfolgreich installiert:")
    for pkg in final_packages:
        print(f"- {pkg}")

if __name__ == "__main__":
    curses.wrapper(main)
