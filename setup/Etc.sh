# Etc.sh - system-wide settings that live in /etc (not in ~/.config), kept in the dotfiles repo.
# Read by Setup.sh (step install_etc_configs). One plain line each:
#     copy_etc <file in the repo> <where it goes> [mode, default 644]
# Files are COPIED to /etc, so re-run the step after you change one in the repo.

copy_etc zram-generator/zram-generator.conf /etc/systemd/zram-generator.conf               # compressed swap in RAM
copy_etc logind/lid-and-power.conf          /etc/systemd/logind.conf.d/lid-and-power.conf  # lid and power key are left to acpid
copy_etc acpid/handler.sh                   /etc/acpi/handler.sh 755                        # lid close locks the screen, power button powers off
copy_etc docker/daemon.json                 /etc/docker/daemon.json                         # DNS servers for containers
copy_etc ly/config.ini                      /etc/ly/config.ini                              # login screen (animation = matrix)
