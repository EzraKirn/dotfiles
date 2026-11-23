# Symlinks.sh - which config folders from the dotfiles repo appear in ~/.config.
# Read by setup.sh (step link_configs). One plain line each:   link <in the repo> <where it appears>
# To add a link, add a line. Existing files at the destination are moved to ~/.config-backup/<time>/.

link "$DOTFILES/alacritty" "$HOME/.config/alacritty"
link "$DOTFILES/dunst"     "$HOME/.config/dunst"
link "$DOTFILES/fish"      "$HOME/.config/fish"
link "$DOTFILES/git"       "$HOME/.config/git"
link "$DOTFILES/i3"        "$HOME/.config/i3"
link "$DOTFILES/lazygit"   "$HOME/.config/lazygit"
link "$DOTFILES/nvim"      "$HOME/.config/nvim"
link "$DOTFILES/picom"     "$HOME/.config/picom"
link "$DOTFILES/polybar"   "$HOME/.config/polybar"
link "$DOTFILES/rofi"      "$HOME/.config/rofi"
