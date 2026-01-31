# Matugen Configuration

Automatic Material You color scheme generator from wallpapers.

## Files

- `config.toml` - Matugen settings and template definitions
- `*-colors.conf` - Color templates for various programs

## How It Works

1. Matugen extracts colors from your current wallpaper
2. Generates Material You color scheme
3. Renders templates and writes to target configs:
   - `hyprland-colors.conf` → `~/.config/hypr/colors.conf`
   - `waybar-colors.conf` → `~/.config/waybar/colors.css`
   - `kitty_colors.conf` → `~/.config/kitty/colors.conf`
   - `gtk-colors.conf` → `~/.config/gtk-{3,4}.0/colors.css`
   - `qtct-colors.conf` → `~/.config/qt5ct/colors/colors.conf`
4. Runs post-hooks to reload programs

## Wallpaper Integration

Configured to work with `swww` for wallpaper setting. When you change wallpapers, matugen automatically updates the color scheme across all applications.

## Usage

Colors regenerate automatically when wallpaper changes via `swww`.
