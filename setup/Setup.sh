#!/usr/bin/env bash
# =====================================================================================
# Setup.sh - turn a bare Arch Linux install into my workstation.
#
#     bash Setup.sh                       # the whole flow, in the order below
#     bash Setup.sh link_configs          # redo ONE step
#     bash Setup.sh clone_latex link_configs     # or several, in the order you give
#
# Run as the NORMAL user (not root). It uses sudo itself.
# Needs: a working network, a user with sudo, your SSH key in ~/.ssh (the repos are pulled over SSH),
# and Packages.sh, Symlinks.sh and Etc.sh in the same folder as this script.
#
# Stops at the first error. Everything printed is also written to ~/setup-<time>.log.
# Safe to run again at any time.
#
# The whole flow (main() at the bottom):
#   preflight              not root? network? ask for the sudo password once
#   show_ssh_reminder      prints how to restore/create the SSH key, waits for Enter (full flow only)
#   install_packages       full upgrade + everything in Packages.sh (git and openssh included), at once
#   configure_services     enable services (one line each)
#   configure_boot_entries write the two boot menu entries (normal + LTS rescue kernel)
#   install_yay            AUR helper (yay-bin), kept as a spare
#   install_firefox_esr    Firefox ESR from Mozilla's tarball (updates itself)
#   install_claude_code    Claude Code, Anthropic's native installer (updates itself)
#   clone_dotfiles         the dotfiles repo
#   clone_firefox          its private firefox submodule
#   clone_latex            LaTexPWR + mktexlsr
#   link_configs           symlinks from Symlinks.sh (old files go to ~/.config-backup/<time>/, never deleted)
#   install_etc_configs    system configs from the repo into /etc, listed in Etc.sh (copied, not linked)
#   check_packages         installed packages against Packages.sh (a report, changes nothing)
#   print_summary
#
# Not part of this script: the system-drive image (backup-system.sh). It must be run from
# another system, because it refuses to image a drive that is mounted.
# =====================================================================================

set -euo pipefail

DOTFILES_URL="git@github.com:EzraKirn/dotfiles.git"
LATEX_URL="git@github.com:EzraKirn/LaTexPWR.git"
DOTFILES="$HOME/dotfiles"
LATEX_DIR="$HOME/texmf/tex/latex/mylatex/LaTexPWR"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS=$(date +%Y%m%d-%H%M%S)
LOG="$HOME/dotfiles/setup/logs/setup-$TS.log"
BACKUP="$HOME/.config-backup/$TS"

# Without a key the first git command below fails and the script stops. This only makes the very first
# connection to github.com non-interactive (it trusts GitHub's host key on first contact).
export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new"

say() { printf '\n==> %s\n' "$*"; }

# Stops the sudo keep-alive loop (started in preflight) when the script ends.
cleanup() {
  if [ -n "${KEEPALIVE:-}" ]; then kill "$KEEPALIVE" 2>/dev/null || true; fi
}
trap cleanup EXIT

preflight() {
  say "Preflight"
  if [ "$EUID" -eq 0 ]; then echo "Run as your normal user, not root."; exit 1; fi
  command -v sudo   >/dev/null || { echo "sudo is not installed."; exit 1; }
  command -v pacman >/dev/null || { echo "This is not Arch (no pacman)."; exit 1; }
  [ -f "$HERE/Packages.sh" ]   || { echo "Packages.sh must be next to this script."; exit 1; }
  [ -f "$HERE/Symlinks.sh" ]   || { echo "Symlinks.sh must be next to this script."; exit 1; }
  [ -f "$HERE/Etc.sh" ]        || { echo "Etc.sh must be next to this script."; exit 1; }
  getent hosts archlinux.org >/dev/null || { echo "No network. Connect first (nmtui)."; exit 1; }
  echo "Log: $LOG"

  sudo -v                                                                 # ask for the sudo password once
  ( while kill -0 "$$" 2>/dev/null; do sudo -n true; sleep 50; done ) >/dev/null 2>&1 &   # keep sudo alive for the long install
  KEEPALIVE=$!
}

show_ssh_reminder() {
  cat <<'EOT'

------------------------------- BEFORE YOU CONTINUE (nothing here is run for you) -------------------------------
The repos are pulled over SSH, so this script needs your SSH key in ~/.ssh. Without it, it stops
at the first git command, after the packages are installed.

  Is the key there and does GitHub accept it?   ssh -T git@github.com     (must say "successfully authenticated")
  Key missing? Restore your old key:            cp /PATH/TO/BACKUP/.ssh/id_* ~/.ssh/ && chmod 600 ~/.ssh/id_*
  Or make a new one and add it to GitHub:       ssh-keygen -t ed25519   then add ~/.ssh/id_ed25519.pub at
                                                https://github.com/settings/ssh/new

(git and ssh may not be installed yet on a bare system: install them first with  sudo pacman -S git openssh less)
-----------------------------------------------------------------------------------------------------------------
EOT
  read -rp "Press Enter when the key is ready (Ctrl+C to stop here)... " _
}

install_packages() {
  say "Packages"
  source "$HERE/Packages.sh"
  sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"
}

# One plain line each. They start at the next boot (enable only).
configure_services() {
  say "Services"
  sudo systemctl enable NetworkManager.service       # network
  sudo systemctl enable bluetooth.service            # bluetooth
  sudo systemctl enable acpid.service                # lid and power buttons
  sudo systemctl enable systemd-timesyncd.service    # clock sync
  sudo systemctl enable fstrim.timer                 # weekly SSD trim
  sudo systemctl enable docker.service               # containers
  sudo systemctl enable tlp.service                  # battery saving
  sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket   # tlp manages radios itself
  sudo systemctl disable getty@tty1.service          # tty1 is handed to the login screen
  sudo systemctl enable ly@tty1.service              # login screen
  sudo systemctl enable systemd-boot-update.service  # keeps the boot loader on the ESP up to date after systemd upgrades
  sudo usermod -aG video,uucp,docker "$USER"         # brightnessctl, serial ports (arduino, picocom), docker without sudo; log out and in to apply
}

# systemd-boot. Both files are written in full. The root UUID changes on every reformat, so it is read here.
configure_boot_entries() {
  say "Boot menu entries"
  sudo test -d /boot/loader/entries || { echo "No /boot/loader/entries (systemd-boot not installed?)"; exit 1; }
  local uuid
  uuid=$(findmnt -no UUID /)

  sudo tee /boot/loader/entries/arch.conf >/dev/null <<EOT
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=UUID=$uuid rw loglevel=3 quiet zswap.enabled=0
EOT

  sudo tee /boot/loader/entries/arch-lts.conf >/dev/null <<EOT
title   Arch Linux (LTS rescue kernel, Intel graphics only)
linux   /vmlinuz-linux-lts
initrd  /intel-ucode.img
initrd  /initramfs-linux-lts.img
options root=UUID=$uuid rw loglevel=3 quiet zswap.enabled=0
EOT
}

# yay: a spare AUR helper. It is itself an AUR package, so this is the one AUR build in the setup.
# yay-bin = prebuilt binary, no Go compile.
install_yay() {
  say "yay (AUR helper)"
  if command -v yay >/dev/null; then echo "already installed"; return; fi
  local dir="$HOME/.cache/aur/yay-bin"
  mkdir -p "$HOME/.cache/aur"
  rm -rf "$dir"
  git clone https://aur.archlinux.org/yay-bin.git "$dir"
  ( cd "$dir" && makepkg -si --noconfirm )
}

# Firefox ESR: Mozilla's own tarball, unpacked in your home directory. Because your user can write
# there, Firefox's built-in updater works and updates ESR by itself (the AUR package disables it).
install_firefox_esr() {
  say "Firefox ESR from Mozilla"
  local dir="$HOME/.local/opt/firefox-esr" tmp="/tmp/firefox-esr.tar"
  if [ -x "$dir/firefox/firefox" ]; then echo "already installed"; return; fi
  mkdir -p "$dir" "$HOME/.local/bin" "$HOME/.local/share/applications"
  curl -fL -o "$tmp" "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=linux64&lang=en-US"
  tar -xf "$tmp" -C "$dir"
  rm -f "$tmp"
  ln -sfn "$dir/firefox/firefox" "$HOME/.local/bin/firefox-esr"
  cat > "$HOME/.local/share/applications/firefox-esr.desktop" <<EOT
[Desktop Entry]
Type=Application
Name=Firefox ESR
Exec=$dir/firefox/firefox %u
Icon=$dir/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;x-scheme-handler/http;x-scheme-handler/https;
EOT
}

# Claude Code: Anthropic's native installer. It puts the launcher at ~/.local/bin/claude and updates
# itself in the background (the AUR package would only update when its maintainer does).
install_claude_code() {
  say "Claude Code"
  if [ -x "$HOME/.local/bin/claude" ]; then echo "already installed"; return; fi
  local tmp
  tmp=$(mktemp)
  curl -fsSL https://claude.ai/install.sh -o "$tmp"
  bash "$tmp"
  rm -f "$tmp"
}

clone_dotfiles() {
  say "Dotfiles"
  if [ -d "$DOTFILES/.git" ]; then
    git -C "$DOTFILES" pull --ff-only
  else
    git clone "$DOTFILES_URL" "$DOTFILES"
  fi
}

clone_firefox() {
  say "Firefox config"
  git -C "$DOTFILES" submodule update --init -- firefox
}

clone_latex() {
  say "LaTexPWR"
  if [ -d "$LATEX_DIR/.git" ]; then
    git -C "$LATEX_DIR" pull --ff-only
  else
    mkdir -p "$(dirname "$LATEX_DIR")"
    git clone "$LATEX_URL" "$LATEX_DIR"
  fi
  mktexlsr "$HOME/texmf"
}

# link <what in the repo> <where it should appear>
link() {
  local src=$1 dst=$2 rel
  [ -e "$src" ] || { echo "Not in the dotfiles repo: $src"; exit 1; }

  if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
    echo "ok      $dst"
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    rel=${dst#"$HOME"/}
    mkdir -p "$BACKUP/$(dirname "$rel")"
    mv "$dst" "$BACKUP/$rel"
    echo "moved   $dst -> $BACKUP/$rel"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "linked  $dst -> $src"
}

# The list of links lives in Symlinks.sh (plain "link" lines), so it is easy to find and edit.
link_configs() {
  say "Symlinks"
  source "$HERE/Symlinks.sh"
}

# copy_etc <file in the repo> <where it goes> [mode, default 644]
# COPIED, not linked: /etc is read very early at boot, before /home may be mounted (it will live on its own drive).
copy_etc() {
  local src="$DOTFILES/$1" dst=$2 mode=${3:-644}
  [ -f "$src" ] || { echo "Not in the dotfiles repo: $src"; exit 1; }
  sudo install -Dm"$mode" "$src" "$dst"
  echo "copied  $src -> $dst"
}

# The list of system configs lives in Etc.sh (plain lines), so it is easy to find and edit.
install_etc_configs() {
  say "System configs in /etc"
  source "$HERE/Etc.sh"
}

# A report only: it changes nothing. yay-bin and yay-bin-debug show up as extras, that is expected.
check_packages() {
  say "Installed packages against Packages.sh"
  source "$HERE/Packages.sh"
  printf '%s\n' "${PACKAGES[@]}" | sort -u > /tmp/listed
  pacman -Qq  | sort -u > /tmp/all        # everything installed, dependencies included
  pacman -Qqe | sort -u > /tmp/explicit   # only what you installed yourself

  echo "== in Packages.sh, not installed =="
  comm -23 /tmp/listed /tmp/all
  echo
  echo "== installed by you, not in Packages.sh =="
  comm -13 /tmp/listed /tmp/explicit
}

print_summary() {
  say "Done. Log: $LOG"
  echo "Replaced config files, if any, are in $BACKUP"
  echo "Reboot now: the upgrade may have replaced the running kernel, and the login screen, network and services start at boot."
}

# With no arguments: the whole flow. With step names: only those steps, in the order given.
main() {
  exec > >(tee -a "$LOG") 2>&1        # from here on, everything on the terminal is also in the log

  if [ "$#" -gt 0 ]; then
    local step
    for step in "$@"; do
      case "$step" in
        preflight|install_packages|configure_services|configure_boot_entries|install_yay|\
        install_firefox_esr|install_claude_code|clone_dotfiles|clone_firefox|clone_latex|link_configs|install_etc_configs|check_packages) ;;
        *) echo "Unknown step: $step"; exit 1 ;;
      esac
    done
    preflight
    for step in "$@"; do "$step"; done
    return
  fi

  preflight
  show_ssh_reminder
  install_packages
  configure_services
  configure_boot_entries
  install_yay
  install_firefox_esr
  install_claude_code
  clone_dotfiles
  clone_firefox
  clone_latex
  link_configs
  install_etc_configs
  check_packages
  print_summary
}

main "$@"
