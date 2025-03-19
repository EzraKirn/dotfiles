#!/bin/bash

MIN_BRIGHTNESS=5   # Minimum brightness limit (in percentage)
MAX_BRIGHTNESS=100 # Maximum brightness limit (in percentage)

get_brightness() {
    current=$(brightnessctl g)
    max=$(brightnessctl m)
    percent=$(( 100 * current / max ))
    echo "$percent%"
}

set_brightness() {
    new_value=$1
    brightnessctl s "$new_value%"
    get_brightness  # Immediately show new brightness
}

increase_brightness() {
    current=$(brightnessctl g)
    max=$(brightnessctl m)
    percent=$(( 100 * current / max ))

    if [ "$percent" -lt "$MAX_BRIGHTNESS" ]; then
        new_percent=$(( percent + 5 ))
        if [ "$new_percent" -gt "$MAX_BRIGHTNESS" ]; then
            new_percent=$MAX_BRIGHTNESS
        fi
        set_brightness "$new_percent"
    else
        get_brightness
    fi
}

decrease_brightness() {
    current=$(brightnessctl g)
    max=$(brightnessctl m)
    percent=$(( 100 * current / max ))

    if [ "$percent" -gt "$MIN_BRIGHTNESS" ]; then
        new_percent=$(( percent - 5 ))
        if [ "$new_percent" -lt "$MIN_BRIGHTNESS" ]; then
            new_percent=$MIN_BRIGHTNESS
        fi
        set_brightness "$new_percent"
    else
        get_brightness
    fi
}

case "$1" in
    up)
        increase_brightness
        ;;
    down)
        decrease_brightness
        ;;
    *)
        get_brightness
        ;;
esac
