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

# Allow override of what to install
# does nothing right now
THING='everything'
if [[ -n "$1" ]]; then
    THING="$1"
    print_status "Will only install $THING"
else
    print_status "Will install everything"
fi

# Create config directories
CONFIG_DIR="$HOME/.config"
print_status "Creating configuration directories..."

mkdir -p "$CONFIG_DIR/waybar"
mkdir -p "$CONFIG_DIR/kitty"
mkdir -p "$CONFIG_DIR/matugen"
mkdir -p "$CONFIG_DIR/gtk-3.0"
mkdir -p "$CONFIG_DIR/gtk-4.0"
mkdir -p "$CONFIG_DIR/qt5ct"
mkdir -p "$CONFIG_DIR/qt6ct"

if [ $THING = 'everything' ] || [ $THING = 'hypr' ]; then
    print_status "Creating hypr (Hyprland, hyprlock) dir..."
    mkdir -p "$CONFIG_DIR/hypr"
    print_status "Installing Hyprland configuration..."
    cp hyprland/hyprland.conf "$CONFIG_DIR/hypr/"
    print_status "Installing Hyprland colors..."
    cp hyprland/colors.conf "$CONFIG_DIR/hypr/"
    print_status "Installing hyprlock config..."
    cp hyprlock/hyprlock.conf "$CONFIG_DIR/hypr/"
fi

if [ $THING = 'everything' ] || [ $THING = 'waybar' ]; then
    print_status "Creating waybar dir..."
    mkdir -p "$CONFIG_DIR/waybar"
    print_status "Installing waybar config..."
    # renaming to config (without extension)
    cp waybar/config.json "$CONFIG_DIR/waybar/config"
    print_status "Installing waybar style guide..."
    cp waybar/style.css "$CONFIG_DIR/waybar/"
    print_status "Installing waybar colors..."
    cp waybar/colors.css "$CONFIG_DIR/waybar/"
fi

if [ $THING = 'everything' ] || [ $THING = 'rofi' ]; then
    print_status "Creating rofi dir..."
    mkdir -p "$CONFIG_DIR/rofi"
    print_status "Installing rofi config..."
    cp rofi/config.rasi "$CONFIG_DIR/rofi/"
fi

if [ $THING = 'everything' ] || [ $THING = 'dunst' ]; then
    print_status "Creating dunst dir..."
    mkdir -p "$CONFIG_DIR/dunst"
    print_status "Installing dunst config..."
    cp dunst/dunstrc "$CONFIG_DIR/dunst/"
fi

if [ $THING = 'everything' ] || [ $THING = 'kitty' ]; then
    print_status "Creating kitty dir..."
    mkdir -p "$CONFIG_DIR/kitty"
    print_status "Installing kitty config..."
    cp kitty/kitty.conf "$CONFIG_DIR/kitty/"
    print_status "Installing kitty colors..."
    cp kitty/colors.conf "$CONFIG_DIR/kitty/"
fi

if [ $THING = 'everything' ] || [ $THING = 'matugen' ]; then
    print_status "Creating matugen dir..."
    mkdir -p "$CONFIG_DIR/matugen"
    print_status "Installing matugen config..."
    cp -r matugen/* "$CONFIG_DIR/matugen/"
fi

if [ $THING = 'everything' ] || [ $THING = 'gtk' ]; then
    print_status "Creating gtk dirs..."
    mkdir -p "$CONFIG_DIR/gtk-3.0"
    mkdir -p "$CONFIG_DIR/gtk-4.0"
    print_status "Installing gtk config..."
    cp gtk/* "$CONFIG_DIR/gtk-3.0/" 2>/dev/null || true
    cp gtk/* "$CONFIG_DIR/gtk-4.0/" 2>/dev/null || true
    
    # Apply GTK theme using gsettings if available
    if command -v gsettings >/dev/null 2>&1; then
        print_status "Applying GTK theme settings via gsettings..."
        gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark" 2>/dev/null || true
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" 2>/dev/null || true
        gsettings set org.gnome.desktop.interface icon-theme "Adwaita" 2>/dev/null || true
    fi
fi

if [ $THING = 'everything' ] || [ $THING = 'qt' ]; then
    print_status "Creating qt dirs..."
    mkdir -p "$CONFIG_DIR/qt5ct"
    mkdir -p "$CONFIG_DIR/qt6ct"
    print_status "Installing qt config..."
    cp -r qt/* "$CONFIG_DIR/qt5ct/" 2>/dev/null || true
    cp -r qt/* "$CONFIG_DIR/qt6ct/" 2>/dev/null || true
fi

if [ $THING = 'everything' ] || [ $THING = 'fonts' ]; then
    mkdir -p "$HOME/.local/share/fonts"
    cp fonts/* "$HOME/.local/share/fonts/" 2>/dev/null || true
    fc-cache -f 2>/dev/null || true
    print_status "✓ Installed fonts"
fi

if [ $THING = 'everything' ] || [ $THING = 'wallpapers' ]; then
    mkdir -p "$HOME/Pictures/wallpapers"
    cp wallpapers/* "$HOME/Pictures/wallpapers/" 2>/dev/null || true
    print_status "✓ Copied wallpapers to ~/Pictures/wallpapers/"
fi

# Run random wallpaper script to set the wallpaper and re-generate the colors
print_status "Setting wallpaper and re-generating colors..."
./random_wallpaper.sh

print_status "Installation complete!"
