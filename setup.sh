#!/bin/bash

# Official pacman packages
pacman_packages=(
  openssh
  git
  less
  lazygit
  alacritty
  fish
  ttf-hack-nerd
  neovim
  npm
  tmux
  neofetch
  polybar
  picom
  rofi
  xclip
  xcolor
  maim
  dunst
  libnotify
  feh
  brightnessctl
  playerctl
  xkeyboard-config
  firefox
  spotify-launcher
  obsidian
  texlive
)

# AUR packages (need yay or other AUR helper)
aur_packages=(
)

echo ">>> Updating system..."
sudo pacman -Syu --noconfirm

echo ">>> Installing official packages..."
for pkg in "${pacman_packages[@]}"; do
  echo "Installing $pkg..."
  sudo pacman -S --noconfirm --needed "$pkg"
done

# Check for yay
if ! command -v yay &> /dev/null; then
  echo ">>> yay not found. Skipping AUR packages."
  echo ">>> To install yay:"
  echo "git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
else
  echo ">>> Installing AUR packages..."
  for aur in "${aur_packages[@]}"; do
    echo "Installing $aur..."
    yay -S --noconfirm --needed "$aur"
  done
fi

echo ">>> Package instalation done"
echo ">>> Creating symlinks for config folders..."

config_dirs=(
  alacritty
  dunst
  fish
  fusuma
  git
  i3
  lazygit
  nvim
  picom
  polybar
  rofi
  tmux
)

for dir in "${config_dirs[@]}"; do
  src="$HOME/dotfiles/$dir"
  dest="$HOME/.config/$dir"

  if [ -L "$dest" ] || [ -d "$dest" ]; then
    echo "Removing existing config at $dest..."
    rm -rf "$dest"
  fi

  echo "Linking $src → $dest"
  ln -s "$src" "$dest"
done

echo ">>> Symlinks created."
