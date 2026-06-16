# Linux_Misc_Files 🐧

A comprehensive collection of Linux scripts, configurations, firmware, and tools for system optimization, gaming, and hardware setup.  
Perfect for Arch Linux users, gamers, and enthusiasts.

---

## 📂 **Structure & Contents**

### 1. **AUR_Packages/**  
   - Local backups of critical/preferred AUR package configurations (`PKGBUILD`, patches)  
   - Created as a secure fallback during AUR infrastructure instability, security incidents, or outages

### 2. **Docs/**  
   - Text documents with solutions for common Linux problems  
   - Examples:  
     - `archinstaller_issues.txt` – Solutions for Arch Linux installation issues  

### 3. **Firmwares/**  
   - Proprietary/experimental firmware for hardware:  
     - Not available in official Arch Linux repositories  

### 4. **Fonts/**  
   - Custom fonts + installation script  
   - Usage:  
     ```bash
     chmod +x Copy_Fonts_archlinux.sh && ./Copy_Fonts_archlinux.sh
     ```

### 5. **GameConfigs/**  
   - Optimized settings for games:  
     - Graphics settings, keybindings, performance tweaks  

### 6. **hw_setup/**  
   - Hardware configuration scripts:  
     - `Pipewire_LineIn_Playback` – Line-In audio routing  
     - `Pipewire_playback_headphones_and_hdmi` – Headphones and HDMI audio routing

### 7. **Increase_Shader_Cache/**  
   - GPU cache tweaks (NVIDIA/AMD/Intel)

### 8. **jdownloader2_installation/**  
   - Installation script for JDownloader 2  
   - `README.txt` – Read if you encounter issues

### 9. **Lutris_Installer_Scripts/**  
   - Custom installation scripts for Lutris

### 10. **Package_Installer_Scripts/**  
   - Automated software installation

### 11. **Scripts/**  
   - Useful small utilities and scripts

---

## 🛠️ **Usage**  
1. Make scripts executable:  
   ```bash
   chmod +x path/to/script.sh
   ```

2. Run scripts:
   ```bash
   ./path/to/script.sh
   ```

## ⚠️ **Important Notes**
- **Always read the README files** in each directory before using the scripts
- **Backup your system** before making major changes
- Some scripts may require **root/sudo privileges**
- Test scripts in a safe environment first

## 🎯 **Target Audience**
- **Arch Linux users** looking for ready-to-use solutions
- **Gamers** wanting optimized Linux gaming setups
- **Linux enthusiasts** exploring system customization
- **Users with specific hardware** needing custom configurations

## 🔧 **Compatibility**
- Primarily tested on **Arch Linux** and **Arch-based distributions**
- Many scripts should work on other Linux distributions with minor modifications
- Some firmware and hardware scripts are hardware-specific

## 📝 **Contributing**
Feel free to contribute your own scripts and improvements! Please ensure:
- Proper documentation is included
- Scripts are tested before submitting
- Clear descriptions of what each script does
