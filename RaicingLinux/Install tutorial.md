# Arch install
Assuming install containing I3 and pulseaudio, ly, nvidia proprieatery, and additional packages: 
- [x] git
- [x] less
- [x] lazygit
- [x] firefox
- [x] obsidian
- [x] alacritty
- [x] feh
- [x] polybar
- [x] xautolock
- [x] ttf-hack-nerd 
- [x] neofetch


- [x] if something is not installed use 
```
sudo pacman -S package_name
```

- [x] configure openssh client to use git over ssh [GitHub Doc](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
``` 
sudo pacman -S openssh
ssh-keygen -t ed25519 -C "wyborskigrzesiek+web@gmail.com"
```
 
- [x] copy key from term and add to GitHub
``` 
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```
 
 - [ ] clone dotfiles repo to home directory
```
git clone git@github.com:EzraKirn/dotfiles.git ~/.
```

- [x] sreate symlinks to alacritty, polybar and I3 (this order) to get basic system config
```
ln -s ~/dotfiles/git/ ~/.config/
ln -s ~/dotfiles/alacritty/ ~/.config/
ln -s ~/dotfiles/polybar/ ~/.config/
ln -s ~/dotfiles/i3/ ~/.config/
```

- [X] Set fish as default shell and reboot
```
sudo pacman -S fish
chsh -s /usr/bin/fish
reboot
```


- [ ] Install alacritty before configuration steps. Add theme.
- My I3 config uses alacritty as term and wont open anything else if you switch config.
```
sudo pacman -S alacritty
url -LO --output-dir ~/.config/alacritty/themes/ https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
```

- [ ] Create symlinks to all config file INSTALL
- script will be listed here one fine day, but for now just create them manually
- remember I3 will create its own default config con remember to rm it before install
```
ln -s ~/dotfiles/alacitty/ ~/.config/
```

- [ ] Install all configured apps
Same here someday script, now just do it by hand
```
sudo pacman -S alacritty
```


- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 


