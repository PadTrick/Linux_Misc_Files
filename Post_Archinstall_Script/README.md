# All in One Install Script ***WIP*** **NOT TESTED YET**
This Script combines all my Install Scripts for a Clean Archlinux Installation

- You can choose which Packages it will install. Like VSCode, Dot.Net, GPU Drivers etc.
- It will install more Packages like fonts, python etc., to give a good system for daily use and gaming.

- It will also configure Pacman Settings (ParallelDownloads=5,ILoveCandy & Colors and if not already done, enable multilib, you can change it manually in **/etc/pacman.conf**)
- In the script, CPUPower will be installed and governor will be enabled to ondemand (you can change it manually in **/etc/default/cpupower**)
- The script will also set the Environment Variables depending on your selected GPU Driver. (you can change it manually in **/etc/environment**)

```bash
    # The following commands are for NVIDIA GPUs like my old GTX 1070Ti etc.
    __GL_SHADER_DISK_CACHE=1
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
    __GL_SHADER_DISK_CACHE_SIZE=100000000000
    #__GL_SHADER_DISK_CACHE_PATH=/var/cache/shaders

    # Enable threaded optomisation for OpenGL.
    __GL_THREADED_OPTIMIZATION=1
```

```bash
    # The following commands are for Mesa (AMD/Intel)
    MESA_GLSL_CACHE=1
    MESA_GLSL_CACHE_DISABLE_CLEANUP=1
    MESA_GLSL_CACHE_MAX_SIZE=102400
    MESA_GLSL_CACHE_DIR=/var/cache/shaders

    # Optional: Threaded Rendering für OpenGL
    # mesa_glthread=true <programmname>
    mesa_glthread=true
```
