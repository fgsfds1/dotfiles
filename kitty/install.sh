#!/usr/bin/env bash
# Installation script for native Kitty configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

print_help() {
    echo -e "${BLUE}Kitty Configuration Installer${NC}"
    echo
    echo "Usage: $0"
    echo
    echo "This script installs the native Kitty terminal configuration."
    echo
    echo "What it does:"
    echo "  - Creates ~/.config/kitty/ directory"
    echo "  - Copies kitty.conf and theme files"
    echo "  - Backs up existing configuration"
}

# Check if help was requested
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    print_help
    exit 0
fi

# Check if kitty is installed
if ! command -v kitty >/dev/null 2>&1; then
    print_error "Kitty is not installed or not in PATH"
    print_status "Install kitty first:"
    print_status "  Arch: sudo pacman -S kitty"
    print_status "  Ubuntu: sudo apt install kitty"
    print_status "  Fedora: sudo dnf install kitty"
    exit 1
fi

print_status "Installing Kitty configuration..."

# Create config directory
CONFIG_DIR="$HOME/.config/kitty"
mkdir -p "$CONFIG_DIR"
print_status "Created configuration directory: $CONFIG_DIR"

# Backup existing configuration
if [[ -f "$CONFIG_DIR/kitty.conf" ]]; then
    backup_file="$CONFIG_DIR/kitty.conf.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$CONFIG_DIR/kitty.conf" "$backup_file"
    print_status "Backed up existing configuration to: $backup_file"
fi

# Copy configuration files
cp kitty.conf "$CONFIG_DIR/"
print_status "✓ Installed kitty.conf"

cp colors.conf "$CONFIG_DIR/"
print_status "✓ Installed kitty theme"

# Install Input fonts if available
if [[ -d "fonts" ]]; then
    # Create user fonts directory
    FONTS_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONTS_DIR"
    
    # Copy Input fonts
    cp fonts/*.ttf "$FONTS_DIR/"
    print_status "✓ Installed Input font files"
    
    # Refresh font cache
    if command -v fc-cache >/dev/null 2>&1; then
        fc-cache -f "$FONTS_DIR"
        print_status "✓ Refreshed font cache"
    fi
fi

print_status "Installation complete!"
echo
print_status "Configuration installed to: $CONFIG_DIR"
print_status "  - Main config: ~/.config/kitty/kitty.conf"
print_status "  - Theme: ~/.config/kitty/Darkside.conf"
if [[ -d "fonts" ]]; then
    print_status "  - Fonts: ~/.local/share/fonts/ (Input font family)"
fi
echo
print_status "To test the configuration:"
print_status "  kitty --config ~/.config/kitty/kitty.conf"
echo
print_status "The configuration will be used automatically on next kitty launch."
