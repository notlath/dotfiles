# Pywal Selection Colors - Automatic Setup

This setup automatically generates optimal text selection/highlight colors based on your pywal color scheme.

## What it does

- **Calculates readable selection colors** with proper contrast ratios (WCAG compliant)
- **Automatically updates** when you change wallpapers with pywal
- **Works across multiple applications**: Alacritty, Kitty, VS Code, GTK apps

## Files Created

### Scripts

- `~/.config/wal/scripts/generate_selection_colors.py` - Python script that calculates optimal selection colors
- `~/.config/wal/postrun.sh` - Hook script that runs after pywal
- `~/.config/wal/wal-wrapper.sh` - Shell wrapper function for seamless integration

### Templates

- `~/.config/wal/templates/alacritty.toml` - Alacritty colors with selection
- `~/.config/wal/templates/kitty.conf` - Updated Kitty template
- `~/.config/wal/templates/colors-gtk.css` - GTK selection colors
- `~/.config/wal/templates/colors-vscode.json` - VS Code theme with selection

## How to Use

### Option 1: Automatic (Recommended)

Just use `wal` as normal - the wrapper function handles everything:

```bash
wal -i ~/Wallpapers/image.jpg
```

The selection colors will be automatically generated and applied!

### Option 2: Manual Generation

If you want to regenerate selection colors without changing wallpaper:

```bash
python3 ~/.config/wal/scripts/generate_selection_colors.py
```

### Option 3: Use pywal's -o flag

You can also call the post-run script directly:

```bash
wal -i ~/Wallpapers/image.jpg -o ~/.config/wal/postrun.sh
```

## How it Works

1. **Pywal generates** base colors from your wallpaper
2. **Python script calculates** optimal selection colors by:
   - Analyzing background/foreground contrast
   - Creating semi-transparent selection backgrounds
   - Ensuring WCAG AA contrast ratio (4.5:1 minimum)
   - Using color8 (bright black) as the base selection color
3. **Templates are processed** and written to `~/.cache/wal/`
4. **Applications reload** to apply new colors

## Generated Colors

After running, check your selection colors:

```bash
cat ~/.cache/wal/selection_colors.json
```

Example output:

```json
{
  "selection_bg": "#393d41",
  "selection_fg": "#cadbef",
  "accent_selection_bg": "#2e3a4f",
  "accent_selection_fg": "#cadbef",
  "contrast_ratio": 7.76
}
```

## Supported Applications

- **Alacritty** - Imports `~/.cache/wal/alacritty.toml` (configured in your alacritty.toml)
- **Kitty** - Uses `~/.cache/wal/colors-kitty.conf`
- **VS Code** - Apply theme by copying `~/.cache/wal/colors-vscode.json`
- **GTK Apps** - Automatic via `~/.config/gtk-3.0/gtk.css`

## Troubleshooting

### Selection colors not updating

1. Reload your terminal/application
2. For Kitty: `killall -SIGUSR1 kitty`
3. For Alacritty: restart the terminal
4. Check that templates exist in `~/.cache/wal/`

### Colors not readable

The script automatically ensures minimum contrast. If colors are still hard to read:

- Adjust the `target_alpha` values in `generate_selection_colors.py`
- Increase for more contrast, decrease for subtler selection

### Script not running automatically

Make sure the wrapper is sourced in your shell:

```bash
source ~/.config/wal/wal-wrapper.sh
```

This is already added to your `~/.zshrc`.

## Customization

Edit `~/.config/wal/scripts/generate_selection_colors.py` to adjust:

- `target_alpha` - transparency of selection (0.25 for dark, 0.20 for light themes)
- Contrast threshold - currently set to 4.5:1 (WCAG AA standard)

## Author

Auto-generated configuration for dynamic text selection colors with pywal.
