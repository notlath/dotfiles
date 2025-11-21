#!/bin/bash

export PATH="${PATH}:${HOME}/.local/bin/"

DIR=$HOME/Wallpapers
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

if [[ $(pidof swww) ]]; then
  pkill swww
fi

swww img ${DIR}/${RANDOMPICS} --transition-type grow --transition-fps 60 --transition-duration 0.5 --transition-bezier 0.65,0,0.35,1 --transition-pos 0.794,0.972 --transition-step 1

sleep 1.25

# Log before reading mode
echo "[$(date '+%H:%M:%S')] Waybar wallpaper: Before reading mode: $(cat ~/.cache/wal/mode 2>/dev/null || echo 'no file')" >> ~/.cache/wal/wallpaper-changes.log

# Check if mode file exists, default to dark if not
if [[ -e "${HOME}/.cache/wal/mode" ]]; then
    MODE="$(cat ~/.cache/wal/mode | tr -d '[:space:]')"
else
    mkdir -p "${HOME}/.cache/wal"
    echo "dark" > "${HOME}/.cache/wal/mode"
    MODE="dark"
fi

# Validate mode value
if [[ "$MODE" != "light" && "$MODE" != "dark" ]]; then
    echo "dark" > "${HOME}/.cache/wal/mode"
    MODE="dark"
fi

if [[ "$MODE" = "light" ]]; then
  wal -i ${DIR}/${RANDOMPICS} -l --cols16
  # Ensure mode persists after wal runs
  echo "light" > "${HOME}/.cache/wal/mode"
  echo "[$(date '+%H:%M:%S')] Waybar wallpaper: Applied LIGHT mode to ${RANDOMPICS}" >> ~/.cache/wal/wallpaper-changes.log
else
  wal -i ${DIR}/${RANDOMPICS} --cols16
  # Ensure mode persists after wal runs
  echo "dark" > "${HOME}/.cache/wal/mode"
  echo "[$(date '+%H:%M:%S')] Waybar wallpaper: Applied DARK mode to ${RANDOMPICS}" >> ~/.cache/wal/wallpaper-changes.log
fi

pywal-discord -t default
wal-telegram --wal

. $HOME/.config/mako/update-colors.sh
. $HOME/.config/spicetify/Themes/Pywal/update-colors.sh