# Deprecated & Orphaned Dotfiles

## Description

This directory contains configuration files for applications that are **no longer installed** on the system or were detected as orphaned. These files are preserved here in case you wish to reinstall the applications later.

## Contents (Deprecated)

- **Neofetch**: System information display (Replaced by Fastfetch?)
- **Btop**: Resource monitor (Replaced by Htop?)
- **MPV**: Media player
- **BetterDiscord**: Enhanced Discord client
- **SwayNC**: Notification center (Replaced by Mako?)
- **qt5ct**: Qt5 settings (Migrated to Qt6/qt6ct?)
- **nwg-dock-hyprland**: Dock for Hyprland
- **nightTab**: Browser extension configuration
- **Starship**: Cross-shell prompt (Using Powerlevel10k/Oh-My-Posh instead?)

## Restoration Guide

If you want to restore any of these configurations, follow the steps below.

### Step 1: Install the Missing Package

Identify which package you want to restore and install it via `pacman` or `yay`.

```bash
# Example: Restore MPV and Btop
sudo pacman -S mpv btop

# Example: Restore Neofetch
sudo pacman -S neofetch

# Example: Restore nwg-dock-hyprland (AUR)
yay -S nwg-dock-hyprland
```

### Step 2: Restore Configuration

You can simply move the folder back to your active configuration directory or symlink it.

**Option A: Move back to active configs (Recommended if permanent)**

```bash
# Example: Restore neofetch
mv ~/.dotfiles/deprecated/.config/neofetch ~/.dotfiles/updated/.config/
ln -sf ~/.dotfiles/updated/.config/neofetch ~/.config/neofetch
```

**Option B: Symlink directly from deprecated (Temporary testing)**

```bash
ln -sf ~/.dotfiles/deprecated/.config/neofetch ~/.config/neofetch
```

## Structure

```
~/.dotfiles/deprecated/
├── .config/
│   ├── neofetch/          # Custom system info display
│   ├── btop/              # Btop resource monitor config
│   ├── mpv/               # MPV media player config
│   ├── BetterDiscord/     # Discord themes/plugins
│   ├── swaync/            # Sway Notification Center
│   ├── qt5ct/             # Qt5 configuration
│   ├── nwg-dock-hyprland/ # Application dock
│   └── starship.toml      # Shell prompt config
```
