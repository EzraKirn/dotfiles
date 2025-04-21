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
  tree-sitter-cli
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
  evince
)

# AUR packages (require yay)
aur_packages=(
)

echo ">>> Updating system..."
sudo pacman -Syu --noconfirm

echo ">>> Installing official packages..."
for pkg in "${pacman_packages[@]}"; do
  echo "Installing $pkg..."
  sudo pacman -S --noconfirm --needed "$pkg"
done

# Check and install yay if not present
if ! command -v yay &> /dev/null; then
  echo ">>> yay not found. Installing yay from AUR..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay || exit
  makepkg -si --noconfirm
  cd ~ || exit
  rm -rf /tmp/yay
else
  echo ">>> yay is already installed."
fi

echo ">>> Installing AUR packages..."
for aur in "${aur_packages[@]}"; do
  echo "Installing $aur..."
  yay -S --noconfirm --needed "$aur"
done

echo ">>> Package installation done"
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
