# packages.sh - every package the basic system uses. One list, edited by hand.
# It is plain bash (an array), so setup scripts load it with:  source setup/packages.sh
# Purposes of each package: PACKAGES.md
PACKAGES=(
  # --- base system and kernels
  base linux-firmware intel-ucode base-devel   # core system, CPU microcode, compilers (needed to build yay)
  linux linux-lts mkinitcpio                   # main kernel + LTS rescue kernel, initramfs builder
  dosfstools efibootmgr                        # FAT (ESP) tools, UEFI boot entries

  # --- hardware, power, network
  networkmanager network-manager-applet        # wifi/network + tray icon
  bluez bluez-utils bluetui                    # bluetooth stack, tools, terminal UI
  zram-generator                               # compressed swap in RAM
  smartmontools                                # disk health (smartctl)
  reflector pacman-contrib                     # fast mirrors; paccache (cache cleanup)
  acpid brightnessctl tlp                      # laptop buttons/lid, screen brightness, battery saving
  udisks2 udiskie                              # auto-mount USB drives
  sof-firmware                                 # audio firmware for this laptop
  restic                                       # backups

  # --- graphics: Intel draws the desktop, NVIDIA on demand (prime-run) and for CUDA
  mesa vulkan-intel intel-media-driver         # Intel 3D, Vulkan, video decoding
  nvidia-open nvidia-utils nvidia-prime nvidia-settings   # NVIDIA driver, nvidia-smi, prime-run, GUI
  # (no nvidia-open-lts on purpose: the LTS kernel is the rescue kernel and boots on Intel only)

  # --- audio (PipeWire replaces PulseAudio/JACK)
  pipewire wireplumber pipewire-pulse pipewire-alsa pavucontrol
  pipewire-jack                                # also stops pacman asking "which JACK provider?" later

  # --- terminal tools
  fish alacritty neovim                        # shell, terminal, editor
  git lazygit openssh rsync                    # version control, git UI, ssh, file sync (rsync: migration)
  ripgrep htop tree wget unzip unrar zip       # search, monitor, listing, download, archives
  xclip man-db less fastfetch imagemagick      # clipboard, manuals, pager, system info, image tools
  tree-sitter-cli                              # syntax parsers for neovim
  csvlens calcurse                             # CSV viewer, calendar

  # --- X11 + i3 desktop
  xorg-server xorg-xinit                       # display server, startx
  xorg-setxkbmap xorg-xset xorg-xprop xorg-xrandr xkeyboard-config   # layouts, screensaver settings, window info, monitors
  i3-wm i3lock xss-lock                        # window manager, screen locker, trigger (idle/sleep -> lock)
  ly                                           # login screen (matrix animation)
  polybar picom rofi rofi-calc                 # bar, compositor, launcher
  dunst libnotify                              # notifications, notify-send
  feh maim xcolor xdg-utils playerctl          # wallpaper, screenshots, colour picker, default apps, media keys
  ttf-hack-nerd ttf-nerd-fonts-symbols noto-fonts-emoji      # fonts

  # --- apps
  spotify-launcher discord obsidian evince     # music, chat, notes, PDF viewer
  kicad kicad-library freecad inkscape octave  # electronics, CAD, vector graphics, maths

  # --- programming
  clang cmake ninja rust lldb                  # C/C++ toolchain, Rust, debugger (lldb-dap for neovim)
  npm python-pipx luacheck doxygen graphviz    # node, python tools, lua linter, docs, diagrams
  arduino-cli picocom nmap                     # arduino, serial terminal, network scanner
  docker docker-compose                        # containers (Postgres etc.)

  # --- LaTeX (all collections I use)
  texlive-basic texlive-bibtexextra texlive-binextra texlive-context texlive-fontsextra
  texlive-fontsrecommended texlive-fontutils texlive-formatsextra texlive-games
  texlive-humanities texlive-langpolish texlive-latex texlive-latexextra
  texlive-latexrecommended texlive-luatex texlive-mathscience texlive-metapost
  texlive-music texlive-pictures texlive-plaingeneric texlive-pstricks
  texlive-publishers texlive-xetex
)
