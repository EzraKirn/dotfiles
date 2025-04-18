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