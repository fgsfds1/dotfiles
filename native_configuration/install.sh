#!/usr/bin/env bash
# Installation script for native Hyprland configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect hostname to determine which config to use
HOSTNAME=$(hostname)
print_status "Detected hostname: $HOSTNAME"

# Check if we have a config for this hostname
if [[ ! -f "hyprland/$HOSTNAME/hyprland.conf" ]]; then
    print_error "No configuration found for hostname '$HOSTNAME'"
    print_status "Available configurations:"
    ls -1 hyprland/*/hyprland.conf 2>/dev/null | sed 's|hyprland/||' | sed 's|/hyprland.conf||' | sed 's/^/  - /'
    echo
    print_status "You can either:"
    print_status "  1. Create a new config: cp hyprland/aya/hyprland.conf hyprland/$HOSTNAME/hyprland.conf"
    print_status "  2. Use existing config: ./install.sh [aya|rin|utsuho]"
    exit 1
fi

# Allow override of hostname
if [[ -n "$1" ]]; then
    HOSTNAME="$1"
    print_status "Using specified configuration: $HOSTNAME"
fi

# Create config directories
CONFIG_DIR="$HOME/.config"
print_status "Creating configuration directories..."

mkdir -p "$CONFIG_DIR/hypr"
mkdir -p "$CONFIG_DIR/waybar"
mkdir -p "$CONFIG_DIR/rofi"
mkdir -p "$CONFIG_DIR/dunst"
mkdir -p "$CONFIG_DIR/kitty"
mkdir -p "$CONFIG_DIR/gtk-3.0"
mkdir -p "$CONFIG_DIR/gtk-4.0"
mkdir -p "$CONFIG_DIR/qt5ct"
mkdir -p "$CONFIG_DIR/qt6ct"

# Copy configurations
print_status "Installing Hyprland configurations..."

# Copy common config
cp hyprland/hyprland.conf "$CONFIG_DIR/hypr/hyprland.conf"
print_status "✓ Installed common Hyprland configuration"

# Copy colors config if it exists
if [[ -f "hyprland/colors.conf" ]]; then
    cp hyprland/colors.conf "$CONFIG_DIR/hypr/"
    print_status "✓ Installed Material Design color palette"
fi

# Copy machine-specific config as main config
cp "hyprland/$HOSTNAME/hyprland.conf" "$CONFIG_DIR/hypr/host.conf"
print_status "✓ Installed $HOSTNAME-specific Hyprland configuration"

# Copy waybar config
cp waybar/config.json "$CONFIG_DIR/waybar/config"
cp waybar/style.css "$CONFIG_DIR/waybar/style.css"
if [[ -f "waybar/colors.css" ]]; then
    cp waybar/colors.css "$CONFIG_DIR/waybar/"
    print_status "✓ Installed Waybar configuration with Material Design colors"
else
    print_status "✓ Installed Waybar configuration"
fi

# Copy hyprlock config
if [[ -f "hyprlock/hyprlock.conf" ]]; then
    cp hyprlock/hyprlock.conf "$CONFIG_DIR/hypr/"
    print_status "✓ Installed Hyprlock configuration"
fi

# Copy rofi config
if [[ -f "rofi/config.rasi" ]]; then
    cp rofi/config.rasi "$CONFIG_DIR/rofi/"
    print_status "✓ Installed Rofi configuration"
fi

# Copy dunst config
if [[ -f "dunst/dunstrc" ]]; then
    cp dunst/dunstrc "$CONFIG_DIR/dunst/"
    print_status "✓ Installed Dunst configuration"
fi

# Copy kitty config
if [[ -f "kitty/kitty.conf" ]]; then
    cp kitty/kitty.conf "$CONFIG_DIR/kitty/"
    print_status "✓ Installed Kitty configuration"
fi

# Copy kitty theme
if [[ -f "kitty/colors.conf" ]]; then
    cp kitty/colors.conf "$CONFIG_DIR/kitty/"
    print_status "✓ Installed Kitty theme"
fi

# Copy GTK theme (works for both GTK 3.0 and 4.0)
if [[ -d "gtk" ]]; then
    cp gtk/* "$CONFIG_DIR/gtk-3.0/" 2>/dev/null || true
    cp gtk/* "$CONFIG_DIR/gtk-4.0/" 2>/dev/null || true
    print_status "✓ Installed GTK theme (3.0 and 4.0)"
fi

# Copy Qt theme (works for both Qt5 and Qt6)
if [[ -d "qt" ]]; then
    cp -r qt/* "$CONFIG_DIR/qt5ct/" 2>/dev/null || true
    cp -r qt/* "$CONFIG_DIR/qt6ct/" 2>/dev/null || true
    print_status "✓ Installed Qt theme (5 and 6)"
fi

# Copy fonts
if [[ -d "fonts" ]]; then
    mkdir -p "$HOME/.local/share/fonts"
    cp fonts/* "$HOME/.local/share/fonts/" 2>/dev/null || true
    fc-cache -f 2>/dev/null || true
    print_status "✓ Installed fonts"
fi

# Create wallpapers directory and copy wallpapers if they exist
if [[ -d "wallpapers" ]]; then
    mkdir -p "$HOME/Pictures/wallpapers"
    cp wallpapers/* "$HOME/Pictures/wallpapers/" 2>/dev/null || true
    print_status "✓ Copied wallpapers to ~/Pictures/wallpapers/"
fi

print_status "Installation complete!"
echo
print_status "Configuration summary:"
print_status "  - Hostname: $HOSTNAME"
print_status "  - Hyprland config: ~/.config/hypr/hyprland.conf"
print_status "  - Hyprland colors: ~/.config/hypr/colors.conf"
print_status "  - Waybar config: ~/.config/waybar/config"
print_status "  - Waybar colors: ~/.config/waybar/colors.css"
print_status "  - Hyprlock config: ~/.config/hypr/hyprlock.conf"
print_status "  - Rofi config: ~/.config/rofi/config.rasi"
print_status "  - Dunst config: ~/.config/dunst/dunstrc"
print_status "  - Kitty config: ~/.config/kitty/kitty.conf"
print_status "  - Kitty theme: ~/.config/kitty/colors.conf"
print_status "  - GTK themes: ~/.config/gtk-3.0/ and ~/.config/gtk-4.0/"
print_status "  - Qt themes: ~/.config/qt5ct/ and ~/.config/qt6ct/"
print_status "  - Fonts: ~/.local/share/fonts/"
print_status "  - Wallpapers: ~/Pictures/wallpapers/"
echo
print_status "To start Hyprland, run: Hyprland"
print_warning "Make sure you have all required packages installed (hyprland, waybar, swww, etc.)"


