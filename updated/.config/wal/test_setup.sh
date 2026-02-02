#!/usr/bin/env bash
# Quick test script to verify pywal selection colors setup

echo "=== Pywal Selection Colors Test ==="
echo ""

# Check if pywal is installed
if ! command -v wal &> /dev/null; then
    echo "❌ pywal is not installed"
    exit 1
fi
echo "✓ pywal is installed"

# Check if Python script exists and is executable
if [ -x ~/.config/wal/scripts/generate_selection_colors.py ]; then
    echo "✓ Selection color generator script is executable"
else
    echo "❌ Selection color generator script not found or not executable"
    exit 1
fi

# Check if post-run script exists
if [ -x ~/.config/wal/postrun.sh ]; then
    echo "✓ Post-run hook script is executable"
else
    echo "❌ Post-run hook script not found or not executable"
    exit 1
fi

# Check if wrapper is sourced
if type wal | grep -q "function"; then
    echo "✓ wal wrapper function is loaded"
else
    echo "⚠ wal wrapper function not loaded (restart shell or run: source ~/.config/wal/wal-wrapper.sh)"
fi

# Check templates
echo ""
echo "=== Template Files ==="
for template in alacritty.toml kitty.conf colors-gtk.css colors-vscode.json; do
    if [ -f ~/.config/wal/templates/$template ]; then
        echo "✓ $template"
    else
        echo "❌ $template missing"
    fi
done

# Check generated files
echo ""
echo "=== Generated Files ==="
if [ -f ~/.cache/wal/colors.json ]; then
    echo "✓ colors.json exists"
    
    # Test generation
    python3 ~/.config/wal/scripts/generate_selection_colors.py
    
    if [ -f ~/.cache/wal/selection_colors.json ]; then
        echo "✓ selection_colors.json generated"
        echo ""
        echo "Current selection colors:"
        cat ~/.cache/wal/selection_colors.json
    else
        echo "❌ selection_colors.json not generated"
    fi
else
    echo "⚠ No pywal colors found. Run: wal -i /path/to/wallpaper.jpg"
fi

echo ""
echo "=== Test Complete ==="
echo ""
echo "To apply colors, run:"
echo "  wal -i ~/Wallpapers/your-image.jpg"
echo ""
echo "Check generated templates in:"
echo "  ~/.cache/wal/alacritty.toml"
echo "  ~/.cache/wal/kitty.conf"
echo "  ~/.cache/wal/colors-vscode.json"
