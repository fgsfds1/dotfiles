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
if [[ ! -f "$HOSTNAME/hyprland.conf" ]]; then
    print_error "No configuration found for hostname '$HOSTNAME'"
    print_status "Available configurations:"
    ls -1 */hyprland.conf 2>/dev/null | sed 's|/hyprland.conf||' | sed 's/^/  - /'
    echo
    print_status "You can either:"
    print_status "  1. Create a new config: cp aya/hyprland.conf $HOSTNAME/hyprland.conf"
    print_status "  2. Use existing config: ./install.sh [aya|rin]"
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

mkdir -p "$CONFIG_DIR/hypr/common"
mkdir -p "$CONFIG_DIR/waybar"
mkdir -p "$CONFIG_DIR/hypr"
mkdir -p "$CONFIG_DIR/rofi"
mkdir -p "$CONFIG_DIR/dunst"

# Copy configurations
print_status "Installing Hyprland configurations..."

# Copy common config
cp common/hyprland.conf "$CONFIG_DIR/hypr/common/"
print_status "✓ Installed common Hyprland configuration"

# Copy machine-specific config as main config
cp "$HOSTNAME/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
print_status "✓ Installed $HOSTNAME-specific Hyprland configuration"

# Copy waybar config
cp waybar/config.json "$CONFIG_DIR/waybar/config"
cp waybar/style.css "$CONFIG_DIR/waybar/style.css"
print_status "✓ Installed Waybar configuration"

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
print_status "  - Waybar config: ~/.config/waybar/config"
print_status "  - Hyprlock config: ~/.config/hypr/hyprlock.conf"
print_status "  - Rofi config: ~/.config/rofi/config.rasi"
print_status "  - Dunst config: ~/.config/dunst/dunstrc"
print_status "  - Wallpapers: ~/Pictures/wallpapers/"
echo
print_status "To start Hyprland, run: Hyprland"
print_warning "Make sure you have all required packages installed (hyprland, waybar, swww, etc.)"


