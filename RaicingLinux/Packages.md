# Packages

Every package that `setup.sh` installs, with its purpose. The source of truth is the `PACKAGES=( ... )` array in `setup.sh`; when you add or remove a package there, update this file too.

- Installed with `pacman` from the official repositories unless the **Source** says otherwise.
- Packages marked **(dep)** are pulled in by something else and are not listed in the script.

## Contents

1. [System core and kernels](#1-system-core-and-kernels)
2. [Hardware, power and network](#2-hardware-power-and-network)
3. [Graphics](#3-graphics)
4. [Audio](#4-audio)
5. [Terminal tools](#5-terminal-tools)
6. [Desktop: X11 and i3](#6-desktop-x11-and-i3)
7. [Applications](#7-applications)
8. [Programming](#8-programming)
9. [LaTeX](#9-latex)
10. [Outside pacman](#10-outside-pacman)
11. [Deliberately not installed](#11-deliberately-not-installed)

---

## 1. System core and kernels

| Package          | Purpose                                                                        |
| ---------------- | ------------------------------------------------------------------------------ |
| `base`           | Minimal Arch system (coreutils, bash, systemd, pacman, ...)                    |
| `linux-firmware` | Firmware blobs for Wi-Fi, GPU and other hardware                               |
| `intel-ucode`    | Intel CPU microcode updates, loaded by the boot entry (`/intel-ucode.img`)     |
| `base-devel`     | Compilers and build tools; needed to build AUR packages such as `yay-bin`      |
| `linux`          | Main (current) kernel                                                          |
| `linux-lts`      | Long-term-support kernel, the **rescue kernel** (boots on Intel graphics only) |

## 2. Hardware, power and network

| Package                  | Purpose                                                                          |
| ------------------------ | -------------------------------------------------------------------------------- |
| `networkmanager`         | Network and Wi-Fi management (`nmtui`, `nmcli`)                                  |
| `network-manager-applet` | Network tray icon (`nm-applet`)                                                  |
| `bluez`                  | Bluetooth stack (the `bluetooth.service` daemon)                                 |
| `bluez-utils`            | Bluetooth command-line tools (`bluetoothctl`)                                    |
| `bluetui`                | Terminal UI for Bluetooth                                                        |
| `zram-generator`         | Compressed swap in RAM (used instead of zswap and a swap partition)              |
| `smartmontools`          | Disk health checks (`smartctl`)                                                  |
| `reflector`              | Picks the fastest pacman mirrors                                                 |
| `pacman-contrib`         | Extra pacman tools, mainly `paccache` (cache cleanup)                            |
| `acpid`                  | Reacts to laptop events such as the lid and power buttons                        |
| `brightnessctl`          | Screen brightness control (needs your user in the `video` group)                 |
| `tlp`                    | Battery and power saving (needs `systemd-rfkill` masked, see the setup document) |
| `udisks2`                | Disk mounting service                                                            |
| `udiskie`                | Automatically mounts USB drives, with a tray icon                                |
| `sof-firmware`           | Audio firmware for this laptop's sound hardware                                  |
| `restic`                 | Encrypted, deduplicated backups of data                                          |

## 3. Graphics

The Intel GPU draws the whole desktop. The NVIDIA GPU is used on demand (`prime-run`) and for CUDA.

|Package|Purpose|
|---|---|
|`mesa`|Open-source OpenGL drivers|
|`vulkan-intel`|Vulkan driver for the Intel GPU|
|`intel-media-driver`|Hardware video decoding and encoding on Intel|
|`nvidia-open`|NVIDIA kernel modules (open version) for the `linux` kernel|
|`nvidia-utils`|NVIDIA userspace libraries and `nvidia-smi`|
|`nvidia-prime`|Provides `prime-run` to start a program on the NVIDIA GPU|
|`nvidia-settings`|NVIDIA settings GUI|

There is **no `nvidia-open-lts`** on purpose: the LTS kernel is the rescue kernel and runs on Intel only.

## 4. Audio

PipeWire replaces PulseAudio and JACK.

|Package|Purpose|
|---|---|
|`pipewire`|The audio and video server|
|`wireplumber`|Session manager for PipeWire (routing, devices)|
|`pipewire-pulse`|PulseAudio compatibility, so apps and `pactl` keep working|
|`pipewire-alsa`|ALSA compatibility|
|`pipewire-jack`|JACK compatibility; also stops pacman asking "which JACK provider?" during an unattended install|
|`pavucontrol`|Volume control GUI|

## 5. Terminal tools

|Package|Purpose|
|---|---|
|`fish`|Login shell|
|`alacritty`|Terminal emulator|
|`neovim`|Editor|
|`git`|Version control|
|`lazygit`|Terminal UI for git|
|`openssh`|SSH client (and `ssh-keygen`)|
|`rsync`|File sync and copy, used for migrating data|
|`ripgrep`|Fast text search (`rg`)|
|`htop`|Process monitor|
|`tree`|Directory tree listing|
|`wget`|File download|
|`unzip` `zip` `unrar`|Archive handling|
|`xclip`|Clipboard from the command line|
|`man-db`|Manual pages (`man`)|
|`less`|Pager; git needs it to page long output|
|`fastfetch`|System information summary|
|`imagemagick`|Image conversion and editing from the command line|
|`tree-sitter-cli`|Builds syntax parsers for neovim|
|`csvlens`|CSV viewer in the terminal|
|`calcurse`|Calendar and to-do in the terminal|

## 6. Desktop: X11 and i3

|Package|Purpose|
|---|---|
|`xorg-server`|X11 display server|
|`xorg-xinit`|`startx` and `.xinitrc`|
|`xorg-setxkbmap`|Keyboard layout switching|
|`xorg-xset`|Screensaver and DPMS settings|
|`xorg-xprop`|Window properties; the lock guard checks for fullscreen windows with it|
|`xorg-xrandr`|Monitor configuration|
|`xkeyboard-config`|Keyboard layout data|
|`i3-wm`|Tiling window manager|
|`i3lock`|Screen locker|
|`xss-lock`|Locks the screen on idle or suspend by calling `i3lock`|
|`ly`|Login manager, runs as `ly@tty1.service`|
|`polybar`|Status bar|
|`picom`|Compositor (transparency, shadows, vsync)|
|`rofi`|Application launcher|
|`rofi-calc`|Calculator mode for rofi|
|`dunst`|Notification daemon|
|`libnotify`|`notify-send`|
|`feh`|Wallpaper setter and image viewer|
|`maim`|Screenshots|
|`xcolor`|Colour picker|
|`xdg-utils`|Default applications (`xdg-open`)|
|`playerctl`|Media keys and player control|
|`ttf-hack-nerd`|Main monospace font with icons|
|`ttf-nerd-fonts-symbols`|Icon fallback glyphs|
|`noto-fonts-emoji`|Emoji font|

## 7. Applications

|Package|Purpose|
|---|---|
|`spotify-launcher`|Downloads and starts the Spotify client|
|`discord`|Chat|
|`obsidian`|Notes|
|`evince`|PDF viewer|
|`kicad`|Electronics design (schematics and PCBs)|
|`kicad-library`|Symbols and footprints for KiCad|
|`freecad`|3D CAD|
|`inkscape`|Vector graphics|
|`octave`|Numerical computing (MATLAB-like)|

## 8. Programming

| Package          | Purpose                                                     |
| ---------------- | ----------------------------------------------------------- |
| `clang`          | C and C++ compiler and language server                      |
| `cmake`          | Build system generator                                      |
| `ninja`          | Fast build tool                                             |
| `rust`           | Rust toolchain                                              |
| `lldb`           | Debugger; also provides `lldb-dap` for neovim               |
| `npm`            | Node package manager                                        |
| `python-pipx`    | Installs Python command-line tools in isolated environments |
| `luacheck`       | Lua linter                                                  |
| `doxygen`        | Documentation generator                                     |
| `graphviz`       | Graph and diagram rendering (`dot`)                         |
| `arduino-cli`    | Arduino build and upload from the command line              |
| `picocom`        | Serial terminal                                             |
| `nmap`           | Network scanner                                             |
| `docker`         | Containers (the service is enabled by the script)           |
| `docker-compose` | Multi-container setups                                      |

For Arduino, per-project libraries live in the project repo. The CLI's own directories are set by `fish/conf.d/arduino.fish` (`ARDUINO_DIRECTORIES_DATA`, `_USER`, `_DOWNLOADS`).

## 9. LaTeX

All TeX Live collections in use. Each one is a separate package.

| Package                    | Purpose                                        |
| -------------------------- | ---------------------------------------------- |
| `texlive-basic`            | Core engines and basic tools                   |
| `texlive-latex`            | LaTeX base                                     |
| `texlive-latexrecommended` | Recommended LaTeX packages                     |
| `texlive-latexextra`       | Many additional LaTeX packages                 |
| `texlive-fontsrecommended` | Recommended fonts                              |
| `texlive-fontsextra`       | Additional fonts                               |
| `texlive-fontutils`        | Font tools                                     |
| `texlive-binextra`         | Extra binaries (`latexmk`, `biber` and others) |
| `texlive-bibtexextra`      | Bibliography styles and tools                  |
| `texlive-mathscience`      | Maths and science packages                     |
| `texlive-pictures`         | TikZ and PGF drawing                           |
| `texlive-pstricks`         | PSTricks drawing                               |
| `texlive-metapost`         | MetaPost graphics                              |
| `texlive-plaingeneric`     | Plain TeX and generic packages                 |
| `texlive-luatex`           | LuaTeX engine and support                      |
| `texlive-xetex`            | XeTeX engine and support                       |
| `texlive-context`          | ConTeXt                                        |
| `texlive-formatsextra`     | Extra TeX formats                              |
| `texlive-publishers`       | Journal and publisher templates                |
| `texlive-humanities`       | Humanities packages                            |
| `texlive-langpolish`       | Polish language support                        |
| `texlive-music`            | Music typesetting                              |
| `texlive-games`            | Chess and other game typesetting               |

My own package, `LaTexPWR`, is cloned into `~/texmf/tex/latex/mylatex/LaTexPWR` by the script and indexed with `mktexlsr`.

## 10. Outside pacman

| Item        | Source                                                             | Purpose                                                                  |
| ----------- | ------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| `yay-bin`   | AUR, built by the script                                           | Spare AUR helper; it is the only AUR build in the script                 |
| Firefox ESR | Mozilla's official tarball, unpacked to `~/.local/opt/firefox-esr` | Browser; the AUR package disables updates, the tarball can update itself |