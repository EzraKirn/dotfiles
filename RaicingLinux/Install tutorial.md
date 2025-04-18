# Arch install
Assuming install containing I3 and pulseaudio, ly, nvidia proprieatery, and additional packages: 
- [ ] List of all uses packages
	- [ ]  openssh
	- [ ] git
	- [ ] less
	- [ ] lazygit
	- [ ] alacritty
	- [ ] fish
	- [ ] ttf-hack-nerd
	- [ ] neovim
	- [ ] npm
	- [ ] tmux
	- [ ] neofetch
	- [ ] polybar
	- [ ] picom
	- [ ] rofi
	- [ ] xclip
	- [ ] xcolor
	- [ ] maim
	- [ ] dunst
	- [ ] feh
	- [ ] brightnessctl
	- [ ] playerctl
	- [ ] xkeyboard-config
	- [ ] firefox
	- [ ] spotify-launcher
	- [ ] obsidian

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
git clone git@github.com:EzraKirn/dotfiles.git ~/dotfiles
```

- [x] run setup script that will update system install all needed packages and create symlinks
```
cd ~/dotfiles
./setup.sh
```

- [ ] Add service to show low battery message
```
sudo ln -s ~/dotfiles/i3/battery_low_warning.service /etc/systemd/system/
sudo ln -s ~/dotfiles/i3/battery_low_warning.timer /etc/systemd/system/
sudo systemctl enable battery_low_warning.timer
reboot
```
	
- [ ] add service to lock on lid close
``` 
sudo ln -s ~/dotfiles/i3/lid-close-xautolock.service /etc/systemd/system/
sudo systemctl enable lid-close-xautolock.service
reboot
```

- [x] ly add bg animation
```
sudo nvim /etc/ly/config.ini
```
and set animation = matrix