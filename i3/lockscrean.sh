#!/bin/bash

# Pre-lock actions
pre_lock() {
  # Add commands to run before locking, e.g., pause music
  pactl set-sink-mute @DEFAULT_SINK@ 1
}

# Lock the screen
lock_screen() {
  i3lock -n -i $HOME/dotfiles/i3/backgrounds/OutsetIslandEvening.png
}

# Post-unlock actions
post_unlock() {
  # Add commands to run after unlocking, e.g., resume music
  pactl set-sink-mute @DEFAULT_SINK@ 0
}

# Main function
main() {
    pre_lock
    lock_screen
    post_unlock
}

main

