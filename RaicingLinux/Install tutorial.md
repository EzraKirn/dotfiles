# Arch install
Assuming install containing I3 and pulseaudio, ly, nvidia proprieatery, and additional packages: 
- [x] openssh
- [x] git
- [x] less

- [x] alacritty
- [x] fish

- [x] polybar

- [x] firefox


- [x] if something is not installed use 
```
sudo pacman -S package_name
```

- [x] configure openssh client to use git over ssh [GitHub Doc](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
``` 
ssh-keygen -t ed25519 -C "wyborskigrzesiek+web@gmail.com"
```
 
- [x] copy key from term and add to GitHub
``` 
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```
 
 - [x] clone dotfiles repo to home directory (if not working copy git config manually)
```
git clone git@github.com:EzraKirn/dotfiles.git ~/.
```

- [x] sreate symlinks to alacritty, polybar, I3 and fish (this order) to get basic system config
```
ln -s ~/dotfiles/git/ ~/.config/
ln -s ~/dotfiles/alacritty/ ~/.config/
ln -s ~/dotfiles/polybar/ ~/.config/
ln -s ~/dotfiles/i3/ ~/.config/
ln -s ~/dotfiles/fish/ ~/.config/
```

- [X] Set fish as default shell and reboot
```
sudo pacman -S fish
chsh -s /usr/bin/fish
reboot
```

### core utis done
now continue with [[Desktop environment setup]]