# ArchLinux Dotfiles for Hyprland

## Description

This repository contains my personal configuration files (dotfiles) tailored for an ArchLinux setup with Hyprland as the window manager. These dotfiles are designed to enhance productivity and aesthetics, providing a seamless and efficient user experience.

## Features

- **Hyprland Configuration**: Custom settings for Hyprland, including workspace rules, animations, and keybindings.
- **Waybar**: A highly customized Waybar configuration for system monitoring and quick access to essential tools.
- **Neofetch**: Personalized Neofetch settings to display system information with a unique ASCII logo.
- **Zsh**: Powerlevel10k theme and useful aliases for a powerful shell experience.
- **Ranger**: File manager configuration with preview scripts and hidden file toggles.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/archlinux-hyprland-dotfiles.git ~/.dotfiles
   ```
2. Navigate to the dotfiles directory:
   ```bash
   cd ~/.dotfiles
   ```
3. Create symbolic links for the configuration files:
   ```bash
   ln -sf ~/.dotfiles/.config/hypr ~/.config/hypr
   ln -sf ~/.dotfiles/.config/waybar ~/.config/waybar
   ln -sf ~/.dotfiles/.config/neofetch ~/.config/neofetch
   ln -sf ~/.dotfiles/.zshrc ~/.zshrc
   ln -sf ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
   ```
4. Install required dependencies:
   - Hyprland
   - Waybar
   - Neofetch
   - Zsh with Powerlevel10k
   - Ranger

## Keybindings

### Hyprland

- **$mainMod + RETURN**: Launch Kitty terminal
- **$mainMod + SPACE**: Open Rofi web search
- **$mainMod + D**: Open Rofi launcher
- **$mainMod + Q**: Kill active window
- **CTRL + ALT + T**: Launch Kitty terminal

### Waybar

- Modules for CPU, memory, battery, and more.

## Preview

![Hyprland Setup](https://via.placeholder.com/800x400.png?text=Hyprland+Setup+Preview)

## License

This project is licensed under the MIT License. See the LICENSE file for details.
