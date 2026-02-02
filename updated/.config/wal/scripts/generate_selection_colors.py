#!/usr/bin/env python3
"""
Generate optimal text selection colors based on pywal palette.
Calculates contrasting, readable selection colors automatically.
"""

import json
import os
from pathlib import Path


def hex_to_rgb(hex_color):
    """Convert hex color to RGB tuple."""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))


def rgb_to_hex(rgb):
    """Convert RGB tuple to hex color."""
    return '#{:02x}{:02x}{:02x}'.format(int(rgb[0]), int(rgb[1]), int(rgb[2]))


def get_luminance(rgb):
    """Calculate relative luminance of a color."""
    r, g, b = [x / 255.0 for x in rgb]
    
    # Apply gamma correction
    r = r / 12.92 if r <= 0.03928 else ((r + 0.055) / 1.055) ** 2.4
    g = g / 12.92 if g <= 0.03928 else ((g + 0.055) / 1.055) ** 2.4
    b = b / 12.92 if b <= 0.03928 else ((b + 0.055) / 1.055) ** 2.4
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def get_contrast_ratio(rgb1, rgb2):
    """Calculate contrast ratio between two colors."""
    lum1 = get_luminance(rgb1)
    lum2 = get_luminance(rgb2)
    
    lighter = max(lum1, lum2)
    darker = min(lum1, lum2)
    
    return (lighter + 0.05) / (darker + 0.05)


def blend_colors(rgb1, rgb2, alpha):
    """Blend two colors with given alpha (0-1)."""
    return tuple(int(rgb1[i] * (1 - alpha) + rgb2[i] * alpha) for i in range(3))


def adjust_opacity(bg_rgb, fg_rgb, target_alpha=0.3):
    """
    Create a selection background by blending foreground with background.
    This simulates a semi-transparent selection.
    """
    return blend_colors(bg_rgb, fg_rgb, target_alpha)


def generate_selection_colors(colors_json_path):
    """Generate optimal selection colors from pywal palette."""
    
    # Load pywal colors
    with open(colors_json_path, 'r') as f:
        data = json.load(f)
    
    bg_hex = data['special']['background']
    fg_hex = data['special']['foreground']
    
    bg_rgb = hex_to_rgb(bg_hex)
    fg_rgb = hex_to_rgb(fg_hex)
    
    # Calculate if theme is dark or light
    bg_luminance = get_luminance(bg_rgb)
    is_dark_theme = bg_luminance < 0.5
    
    # Generate selection background (semi-transparent foreground over background)
    if is_dark_theme:
        # For dark themes: use a lighter, semi-transparent overlay
        selection_bg_rgb = adjust_opacity(bg_rgb, fg_rgb, target_alpha=0.25)
    else:
        # For light themes: use a darker, semi-transparent overlay
        selection_bg_rgb = adjust_opacity(bg_rgb, fg_rgb, target_alpha=0.20)
    
    # Selection foreground should be the original foreground for maximum contrast
    selection_fg_rgb = fg_rgb
    
    # Verify contrast ratio (aim for at least 4.5:1 for readability)
    contrast = get_contrast_ratio(selection_fg_rgb, selection_bg_rgb)
    
    # If contrast is too low, adjust
    if contrast < 4.5:
        if is_dark_theme:
            # Make selection background darker
            selection_bg_rgb = blend_colors(bg_rgb, (0, 0, 0), 0.3)
        else:
            # Make selection background lighter
            selection_bg_rgb = blend_colors(bg_rgb, (255, 255, 255), 0.3)
    
    selection_bg_hex = rgb_to_hex(selection_bg_rgb)
    selection_fg_hex = rgb_to_hex(selection_fg_rgb)
    
    # Also generate some alternative selections using accent colors
    accent_colors = [data['colors'][f'color{i}'] for i in range(1, 7)]
    
    # Find the most vibrant accent color for alternative selection
    max_saturation = 0
    best_accent = accent_colors[0]
    
    for color in accent_colors:
        rgb = hex_to_rgb(color)
        r, g, b = [x / 255.0 for x in rgb]
        max_c = max(r, g, b)
        min_c = min(r, g, b)
        saturation = 0 if max_c == 0 else (max_c - min_c) / max_c
        
        if saturation > max_saturation:
            max_saturation = saturation
            best_accent = color
    
    # Create accent-based selection (for special UI elements)
    accent_rgb = hex_to_rgb(best_accent)
    accent_selection_bg = rgb_to_hex(adjust_opacity(bg_rgb, accent_rgb, 0.35))
    
    return {
        'selection_bg': selection_bg_hex,
        'selection_fg': selection_fg_hex,
        'accent_selection_bg': accent_selection_bg,
        'accent_selection_fg': fg_hex,
        'contrast_ratio': round(contrast, 2)
    }


def main():
    """Main function to generate and save selection colors."""
    colors_json = Path.home() / '.cache' / 'wal' / 'colors.json'
    
    if not colors_json.exists():
        print(f"Error: {colors_json} not found. Run pywal first.")
        return 1
    
    selection_colors = generate_selection_colors(str(colors_json))
    
    # Save to JSON file
    output_file = Path.home() / '.cache' / 'wal' / 'selection_colors.json'
    with open(output_file, 'w') as f:
        json.dump(selection_colors, f, indent=4)
    
    print(f"✓ Generated selection colors (contrast: {selection_colors['contrast_ratio']}:1)")
    print(f"  Selection BG: {selection_colors['selection_bg']}")
    print(f"  Selection FG: {selection_colors['selection_fg']}")
    
    return 0


if __name__ == '__main__':
    exit(main())
