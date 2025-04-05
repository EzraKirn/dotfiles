#!/bin/bash
ss_path="$HOME/Screenshots/$(date "+%d-%m-%Y_%H-%M-%S").png"  

echo "$HOME"
echo "$ss_path"

ss_fullscreen() {
  maim "$ss_path"
}

ss_fullscreen_show() {
  maim "$ss_path"
  feh "$ss_path"
}

ss_select() {
  maim -s "$ss_path"
}

ss_select_show() {
  maim -s "$ss_path"
  feh "$ss_path"
}


case "$1" in
  fs)
    ss_fullscreen
    ;;
  fs_s)
    ss_fullscreen_show
    ;;
  s)
    ss_select
    ;;
  s_s)
    ss_select_show
    ;;
esac
