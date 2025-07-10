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
  texlive
  kicad
  acpid
)

# AUR packages (require yay)
aur_packages=(
  xidlehook
)

echo ">>> Updating system..."
sudo pacman -Syu --noconfirm

echo ">>> --- --- --- --- --- ---"
echo ">>> Installing official packages..."
for pkg in "${pacman_packages[@]}"; do
  echo "Installing $pkg..."
  sudo pacman -S --noconfirm --needed "$pkg"
done

# Check and install yay if not present
echo ">>> --- --- --- --- --- ---"
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

echo ">>> --- --- --- --- --- ---"
echo ">>> Installing AUR packages..."
for aur in "${aur_packages[@]}"; do
  echo "Installing $aur..."
  yay -S --noconfirm --needed "$aur"
done
echo ">>> Package installation done"


echo ">>> --- --- --- --- --- ---"
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


# === LaTeX Setup ===
echo ">>> --- --- --- --- --- ---"
echo ">>> Setting up LaTeX environment..."

# Directory for personal texmf tree
TEXMF_DIR="$HOME/texmf/tex/latex/mylatex/"

# Clone LaTeX repo into texmf tree
if [ ! -d "$TEXMF_DIR" ]; then
  echo "Creating $TEXMF_DIR..."
  mkdir -p "$TEXMF_DIR"
fi

LATEX_REPO_DIR="$TEXMF_DIR/LaTexPWR"

if [ -d "$LATEX_REPO_DIR" ]; then
  echo "Updating existing LaTeX repo at $LATEX_REPO_DIR..."
  cd "$LATEX_REPO_DIR" && git pull
else
  echo "Cloning LaTeX repo to $LATEX_REPO_DIR..."
  git clone git@github.com:EzraKirn/LaTexPWR.git "$LATEX_REPO_DIR"
fi

# Update texmf database
echo "Updating texmf database..."
mktexlsr "$TEXMF_DIR"

echo ">>> LaTeX environment setup complete."
