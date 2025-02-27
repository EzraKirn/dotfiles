# #!/bin/bash
#
# # Get the list of directories in the current folder, excluding .git, autostart, and .
# cwd=$(dirs)
# dirs=$(find . -mindepth 1 -maxdepth 1 -type d ! -name .git ! -name autostart)
# dirs="${dirs//./$cwd}"
# # # Loop through each directory and echo its name
# for dir in $dirs
# do
#   ln -sf $dir ~/.config
#   # echo "$dir"
# done
#
#
ln -sf ~/dotfiles/alacritty ~/.config
ln -sf ~/dotfiles/findex ~/.config
ln -sf ~/dotfiles/fish ~/.config
ln -sf ~/dotfiles/fusuma ~/.config
ln -sf ~/dotfiles/git ~/.config
ln -sf ~/dotfiles/i3 ~/.config
ln -sf ~/dotfiles/lazygit ~/.config
ln -sf ~/dotfiles/nautilus ~/.config
ln -sf ~/dotfiles/nvim ~/.config
ln -sf ~/dotfiles/tmux ~/.config
