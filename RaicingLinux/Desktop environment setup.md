## Used tools and packages
- Should be installed right now
	- [[nmtui]]
	- [[pulseaudio]]
	- [[polybar]]
	- ly
	- systemd
	- brightnessctl
	- xkeyboard
## config steps
- [x] Just install, no confing currently present
	- [x] ttf-hack-nerd 
	- [x] lazygit
	- [x] obsidian
	- [x] neofetch

- [ ] install and add symlinks
	- [x] neovim
	- [x] dunst
	- [x] rofi
	- [x] [[picom]]
	- [ ] [[nnn]]
	- [ ] [[calcurse]]

- [x] [[Polybar]] and dependencies
	- [x] feh
	- [x] xautolock
	- [x] add service to lock on lid close
	``` 
	sudo ln -s ~/dotfiles/i3/lid-close-xautolock.service /etc/systemd/system/
	sudo systemctl enable lid-close-xautolock.service
	reboot
	```
	- [x] brightnessctl
	- [x] playerctl
	- [x] spotify-luncher


- [x] ly add bg animation
```
sudo nvim /etc/ly/config.ini
```
and set animation = matrix