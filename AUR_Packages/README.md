```markdown
# AUR Packages Backup 📦

A local backup collection of essential Arch User Repository (AUR) packages, including their `PKGBUILD` files, patches, and install configurations.

---

## 🛡️ **Why this directory exists**
Due to ongoing security incidents, supply-chain attacks, or sudden removals within the official AUR ecosystem, this directory serves as a secure, independent backup. It ensures that critical packages, custom drivers, and gaming utilities remain available for manual building and deployment even if the upstream AUR is compromised or unavailable.

---

## 📂 **Included Packages**

| Package Name | Description |
| :--- | :--- |
| **aic94xx-firmware** | Adaptec SAS 44300/48300/58300 sequencer firmware |
| **ast-fw** | ASPEED Graphics firmware |
| **downgrade** | Bash script to easily downgrade packages using the Arch Linux Archive |
| **heroic-games-launcher-bin** | Native GUI Epic Games, GOG, and Prime Gaming launcher |
| **lib32-nvidia-580xx-utils** | NVIDIA 32-bit graphics utilities (580xx legacy/specific branch) |
| **lib32-vkbasalt** | 32-bit Vulkan post-processing layer |
| **mangojuice** | A simple external tool/UI or helper wrapper for MangoHud |
| **nvidia-580xx-settings** | Tool for configuring the NVIDIA graphics driver (580xx branch) |
| **nvidia-580xx-utils** | NVIDIA graphics utilities and libraries (580xx branch) |
| **protonplus** | Simple Wine and Proton downloader for various launchers |
| **protontricks-git** | Winetricks wrapper for Steam Proton games (Development version) |
| **protonup-qt** | Graphic user interface for managing Proton-GE and Luxtorpeda installs |
| **upd72020x-fw** | Firmware for Renesas uPD720201/uPD720202 USB 3.0 controllers |
| **visual-studio-code-bin** | Visual Studio Code (Binary release) |
| **vkbasalt** | Vulkan post-processing layer for visual enhancements in games |
| **wd719x-firmware** | Western Digital WD719x SCSI driver firmware |
| **xone-dkms-git** | Modern Linux kernel driver for Xbox One and Xbox Series X/S controllers |
| **xone-dongle-firmware** | Firmware for the Xbox One Wireless Dongle |
| **xwaylandvideobridge** | Utility to bridge Wayland video sharing to X11 applications |

---

## 🛠️ **How to Build & Install**

To manually compile and install any of these packages using the backed-up configurations, follow these standard Arch building steps:

1. Navigate into the specific package directory:
   ```bash
   cd AUR_Packages/package-name

```

2. Review the `PKGBUILD` and any accompanying patches to ensure everything is secure and unmodified:
```bash
less PKGBUILD

```


3. Compile and install the package using `makepkg`:
```bash
makepkg -si

```



---

## ⚠️ **Important Notes**

* **Verify Upstream Changes:** Since these are static backups, they will not auto-update. Always cross-reference with official development cycles when updating your system.
* **Dependencies:** Ensure all required core dependencies are resolved via `pacman` prior to running `makepkg`.
* **System Backups:** Some kernel modules (like `xone-dkms-git`) or hardware-specific firmwares interact deeply with your core system. Always back up your environment before testing critical low-level software.
