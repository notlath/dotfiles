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

# Ensure the mode file directory exists
mkdir -p "${HOME}/.cache/wal"

if [[ -e "${HOME}/.cache/wal/mode" ]]; then
    MODE="$(cat ~/.cache/wal/mode | tr -d '[:space:]')"
else
    echo "dark" > "${HOME}/.cache/wal/mode"
    MODE="dark"
fi

# Default to dark if mode file is empty or invalid
if [[ -z "$MODE" ]] || [[ "$MODE" != "light" && "$MODE" != "dark" ]]; then
    echo "dark" > "${HOME}/.cache/wal/mode"
    MODE="dark"
fi

if [[ "$MODE" = "light" ]]; then
    notify-send "Switching to Dark Mode" "Applying dark theme..."

    wal -i "$CURRENTIMG" --cols16
    
    # Write mode file and verify
    echo "dark" > "${HOME}/.cache/wal/mode"
    sync
    
    # Log for debugging
    echo "[$(date '+%H:%M:%S')] Switched from light to dark" >> ~/.cache/wal/theme-toggle.log

    notify-send "Dark Mode Activated" "Theme changed successfully!"
else
    notify-send "Switching to Light Mode" "Applying light theme..."

    wal -i "$CURRENTIMG" -l --cols16
    
    # Write mode file and verify
    echo "light" > "${HOME}/.cache/wal/mode"
    sync

# Don't run these during theme toggle - they're for wallpaper changes
# . $HOME/.config/mako/update-colors.sh
# . $HOME/.config/spicetify/Themes/Pywal/update-colors.sh

# Just reload mako without the "Wallpaper updated" notification
. "${HOME}/.cache/wal/colors.sh"
conffile="${HOME}/.config/mako/config"
declare -A colors
colors=(["background-color"]="$background" ["text-color"]="$foreground" ["border-color"]="$color13")
for color_name in "${!colors[@]}"; do
  sed -i "0,/^$color_name.*/{s//$color_name=${colors[$color_name]}/}" $conffile
done
makoctl reload
    echo "[$(date '+%H:%M:%S')] Switched from dark to light" >> ~/.cache/wal/theme-toggle.log

    notify-send "Light Mode Activated" "Theme changed successfully!"
fi

# Update all applications with new colors
pywalfox update
pywal-discord -t default
. $HOME/.config/mako/update-colors.sh
. $HOME/.config/spicetify/Themes/Pywal/update-colors.sh

# Reload waybar to pick up new colors
killall -SIGUSR2 waybar