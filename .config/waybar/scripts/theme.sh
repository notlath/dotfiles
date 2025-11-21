#!/bin/bash

export PATH="${PATH}:${HOME}/.local/bin/"

# Source the colors.sh to get the actual wallpaper path
if [[ -f "${HOME}/.cache/wal/colors.sh" ]]; then
    source "${HOME}/.cache/wal/colors.sh"
    CURRENTIMG="$wallpaper"
else
    echo "Error: colors.sh not found. Please run wal first."
    notify-send "Error" "Pywal colors not found. Please set a wallpaper first."
    exit 1
fi

MODE=""

if [[ -e "${HOME}/.cache/wal/mode" ]]; then
    MODE="$(<~/.cache/wal/mode )"
else
    cd ${HOME}/.cache/wal && touch mode

    set -o noclobber
    echo "dark" >| ${HOME}/.cache/wal/mode

    MODE="dark"
fi

if [[ $MODE = "light" ]]; then
    notify-send "Changing to dark theme..."

    MODE="dark"

    wal -i "$CURRENTIMG" --cols16 -n

    set -o noclobber
    echo "dark" >| ${HOME}/.cache/wal/mode

    notify-send "Changed to dark theme!"
else
    notify-send "Changing to light theme..."

    MODE="light"

    wal -i "$CURRENTIMG" -l --cols16 -n

    set -o noclobber
    echo "light" >| ${HOME}/.cache/wal/mode

    notify-send "Changed to light theme!"
fi

# Update all applications with new colors
pywalfox update
pywal-discord -t default
. $HOME/.config/mako/update-colors.sh
. $HOME/.config/spicetify/Themes/Pywal/update-colors.sh

# Reload waybar to pick up new colors
killall -SIGUSR2 waybar