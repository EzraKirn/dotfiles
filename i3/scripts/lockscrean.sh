#!/bin/bash

# Pre-lock actions
pre_lock() {
  pactl set-sink-mute @DEFAULT_SINK@ 1
}

# Lock the screen
lock_screen() {
  # pkill picom
  i3lock -n -i $HOME/dotfiles/i3/backgrounds/OutsetIslandEvening.png
  # picom
}

# Post-unlock actions
post_unlock() {
  setxkbmap us,pl -option caps:swapescape
  pactl set-sink-mute @DEFAULT_SINK@ 0
}

# Main function
main() {
    pre_lock
    lock_screen
    post_unlock
}

main
