# Active Dotfiles for Hyprland

## Description

This directory contains the **active** configuration files for the currently installed applications on your ArchLinux system. These files are essential for your current Hyprland setup.

## Features

- **Hyprland**: Modern Wayland compositor with custom animations, window rules, and workspace management
- **Waybar**: Highly customized status bar with system monitoring, workspace indicators, and custom modules
- **Pywal**: Dynamic color scheme generation from wallpapers with templates for all applications
- **Kitty**: GPU-accelerated terminal emulator with Pywal color integration
- **Rofi**: Application launcher, web search, emoji picker, wallpaper selector, and power menu
- **Fastfetch**: Faster system information display alternative
- **Fish**: Friendly interactive shell alternative
- **Ranger**: Terminal-based file manager with preview scripts
- **Micro**: Intuitive terminal-based text editor
- **Mako**: Notification daemon for Wayland
- **Spicetify**: Themed Spotify client
- **Alacritty & Foot**: Alternative terminal emulators
- **nwg-shell**: Collection of GTK-based tools (drawer, look, launchers)
- **Wpaperd**: Wallpaper daemon
- **Thunar**: Graphical file manager
- **Cava**: Audio visualizer

## Installation / Update Guide

### Prerequisites

Ensure you have a generic ArchLinux installation with `base-devel`, `git`.

### Step 1: Install Core Packages

These are the packages currently configured in this folder:

```bash
# Display server and compositor
sudo pacman -S hyprland xdg-desktop-portal-hyprland

# Terminal and shell
sudo pacman -S kitty alacritty foot fish

# Status bar
sudo pacman -S waybar

# Application launcher and menus
sudo pacman -S rofi wofi

# Notification daemon
sudo pacman -S mako

# Editors
sudo pacman -S micro

# Audio
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pavucontrol

# File managers
sudo pacman -S ranger thunar

# System utilities
sudo pacman -S fastfetch htop polkit-kde-agent

# Screenshot utility
sudo pacman -S grim slurp wl-clipboard

# Fonts
sudo pacman -S ttf-font-awesome ttf-jetbrains-mono noto-fonts noto-fonts-emoji

# Image viewer and wallpaper
sudo pacman -S wpaperd

# Python and Pywal for theming
sudo pacman -S python python-pip qt6ct kvantum
pip install pywal

# Audio visualizer
sudo pacman -S cava
```

### Step 2: Install AUR Packages

```bash
# Spicetify for Spotify theming
yay -S spicetify-cli

# nwg-shell tools (excluding nwg-dock-hyprland)
yay -S nwg-look nwg-drawer nwg-launchers kanshi
```

### Step 3: Symlink Configurations

```bash
# Backup existing configs
mkdir -p ~/.config-backup
cp -r ~/.config/* ~/.config-backup/ 2>/dev/null || true

# Create symbolic links for active configurations
ln -sf ~/.dotfiles/updated/.config/hypr ~/.config/hypr
ln -sf ~/.dotfiles/updated/.config/waybar ~/.config/waybar
ln -sf ~/.dotfiles/updated/.config/kitty ~/.config/kitty
ln -sf ~/.dotfiles/updated/.config/rofi ~/.config/rofi
ln -sf ~/.dotfiles/updated/.config/fastfetch ~/.config/fastfetch
ln -sf ~/.dotfiles/updated/.config/ranger ~/.config/ranger
ln -sf ~/.dotfiles/updated/.config/mako ~/.config/mako
ln -sf ~/.dotfiles/updated/.config/wal ~/.config/wal
ln -sf ~/.dotfiles/updated/.config/gtk-3.0 ~/.config/gtk-3.0
ln -sf ~/.dotfiles/updated/.config/spicetify ~/.config/spicetify
ln -sf ~/.dotfiles/updated/.config/htop ~/.config/htop
ln -sf ~/.dotfiles/updated/.config/alacritty ~/.config/alacritty
ln -sf ~/.dotfiles/updated/.config/cava ~/.config/cava
ln -sf ~/.dotfiles/updated/.config/fish ~/.config/fish
ln -sf ~/.dotfiles/updated/.config/foot ~/.config/foot
ln -sf ~/.dotfiles/updated/.config/gtk-2.0 ~/.config/gtk-2.0
ln -sf ~/.dotfiles/updated/.config/gtk-4.0 ~/.config/gtk-4.0
ln -sf ~/.dotfiles/updated/.config/kanshi ~/.config/kanshi
ln -sf ~/.dotfiles/updated/.config/Kvantum ~/.config/Kvantum
ln -sf ~/.dotfiles/updated/.config/micro ~/.config/micro
ln -sf ~/.dotfiles/updated/.config/nwg-drawer ~/.config/nwg-drawer
ln -sf ~/.dotfiles/updated/.config/nwg-launchers ~/.config/nwg-launchers
ln -sf ~/.dotfiles/updated/.config/nwg-look ~/.config/nwg-look
ln -sf ~/.dotfiles/updated/.config/qt6ct ~/.config/qt6ct
ln -sf ~/.dotfiles/updated/.config/wofi ~/.config/wofi
ln -sf ~/.dotfiles/updated/.config/wpaperd ~/.config/wpaperd
ln -sf ~/.dotfiles/updated/.config/autostart ~/.config/autostart
ln -sf ~/.dotfiles/updated/.config/mimeapps.list ~/.config/mimeapps.list
```

## Structure

```
~/.dotfiles/updated/
├── .config/
│   ├── hypr/              # Hyprland compositor configuration
│   ├── waybar/            # Status bar configuration
│   ├── kitty/             # Terminal emulator (Kitty)
│   ├── alacritty/         # Terminal emulator (Alacritty)
│   ├── foot/              # Terminal emulator (Foot)
│   ├── fish/              # Fish shell configuration
│   ├── rofi/              # Application launcher themes
│   ├── wofi/              # Wayland launcher configuration
│   ├── fastfetch/         # System info display
│   ├── ranger/            # File manager config
│   ├── mako/              # Notification daemon
│   ├── wal/               # Pywal templates
│   ├── spicetify/         # Spotify theming
│   ├── micro/             # Micro text editor
│   ├── htop/              # Resource monitor
│   ├── cava/              # Audio visualizer
│   ├── kanshi/            # Display profile manager
│   ├── wpaperd/           # Wallpaper daemon
│   ├── nwg-*/             # nwg-drawer, launchers, look
│   ├── gtk-*/             # GTK 2/3/4 settings
│   ├── Kvantum/           # Qt style theme
│   └── qt6ct/             # Qt6 configuration tool
```
