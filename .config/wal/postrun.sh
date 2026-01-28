#!/usr/bin/env bash
# Pywal post-run hook script
# This script runs automatically after pywal generates colors

# Generate optimal selection colors
python3 ~/.config/wal/scripts/generate_selection_colors.py

# Reload applications to apply new colors
reload_apps() {
    # Reload kitty if running
    if command -v kitty &> /dev/null; then
        killall -SIGUSR1 kitty 2>/dev/null || true
    fi
    
    # Reload VS Code settings if file exists
    if [ -f ~/.cache/wal/colors-vscode.json ]; then
        mkdir -p ~/.config/Code/User
        cp ~/.cache/wal/colors-vscode.json ~/.config/Code/User/wal-colors.json 2>/dev/null || true
    fi
    
    # Apply GTK theme
    if [ -f ~/.cache/wal/colors-gtk.css ]; then
        mkdir -p ~/.config/gtk-3.0
        cat > ~/.config/gtk-3.0/gtk.css << EOF
@import url('file://$HOME/.cache/wal/colors-gtk.css');
EOF
    fi
}

reload_apps

echo "✓ Pywal post-run complete - selection colors updated"
