#!/usr/bin/env bash
# Installation script for native Hyprland configuration
# This script installs and configures all Hyprland-related files and other dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration directories
CONFIG_DIR="$HOME/.config"
XDG_DATA_DIR="$HOME/.local/share"

# Print functions for status messages
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Print usage information
print_usage() {
    cat <<EOF
Usage: $0 [OPTIONS]

Install Hyprland dotfiles and configuration

OPTIONS:
    hypr        Install Hyprland, hyprlock, hypridle, and colors
    waybar      Install Waybar configuration
    rofi        Install Rofi configuration
    dunst       Install Dunst notification daemon configuration
    kitty       Install Kitty terminal configuration
    matugen     Install Matugen color schemes
    gtk         Install GTK configuration
    qt          Install Qt theme configuration
    fonts       Install additional fonts
    wallpapers  Install wallpaper files
    everything  Install all components (default)

Example:
    $0
    $0 hypr
    $0 hypr waybar rofi

EOF
}

# ============================================================================
# Configuration management functions
# ============================================================================

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ============================================================================
# Component: Hyprland (hypr)
# ============================================================================

install_hypr() {
    print_status "Installing Hyprland configuration..."

    # Create directories
    mkdir -p "$CONFIG_DIR/hypr"

    # Copy Hyprland configuration
    if [ -f "hypr/hyprland.conf" ]; then
        cp hypr/hyprland.conf "$CONFIG_DIR/hypr/"
        print_status "Installed hyprland.conf"
    else
        print_error "hypr/hyprland.conf not found"
        return 1
    fi

    # Copy Hyprland colors
    if [ -f "hypr/colors.conf" ]; then
        cp hypr/colors.conf "$CONFIG_DIR/hypr/"
        print_status "Installed colors.conf"
    else
        print_error "hypr/colors.conf not found"
        return 1
    fi

    # Copy Hyprlock configuration
    if [ -f "hypr/hyprlock.conf" ]; then
        cp hypr/hyprlock.conf "$CONFIG_DIR/hypr/"
        print_status "Installed hyprlock.conf"
    else
        print_error "hypr/hyprlock.conf not found"
        return 1
    fi

    # Copy Hypridle configuration
    if [ -f "hypr/hypridle.conf" ]; then
        cp hypr/hypridle.conf "$CONFIG_DIR/hypr/"
        print_status "Installed hypridle.conf"
    else
        print_error "hypr/hypridle.conf not found"
 fi
}

# ============================================================================
# Component: Waybar
# ============================================================================

install_waybar() {
    print_status "Installing Waybar configuration..."

    # Create directory
    mkdir -p "$CONFIG_DIR/waybar"

    # Copy Waybar config
    if [ -f "waybar/config.json" ]; then
        # Create symlinks if possible, or copy
        [ -L "$CONFIG_DIR/waybar/config" ] && rm "$CONFIG_DIR/waybar/config"
        [ -f "$CONFIG_DIR/waybar/config" ] || ln -sf "$PWD/waybar/config.json" "$CONFIG_DIR/waybar/config"
        [ -f "$CONFIG_DIR/waybar/config" ] || cp waybar/config.json "$CONFIG_DIR/waybar/config"
        print_status "Installed waybar/config.json"
    fi

    # Copy Waybar style
    if [ -f "waybar/style.css" ]; then
        [ -L "$CONFIG_DIR/waybar/style.css" ] && rm "$CONFIG_DIR/waybar/style.css"
        [ -f "$CONFIG_DIR/waybar/style.css" ] || ln -sf "$PWD/waybar/style.css" "$CONFIG_DIR/waybar/"
        [ -f "$CONFIG_DIR/waybar/style.css" ] || cp waybar/style.css "$CONFIG_DIR/waybar/"
        print_status "Installed waybar/style.css"
    fi

    # Copy Waybar colors
    if [ -f "waybar/colors.css" ]; then
        [ -L "$CONFIG_DIR/waybar/colors.css" ] && rm "$CONFIG_DIR/waybar/colors.css"
        [ -f "$CONFIG_DIR/waybar/colors.css" ] || ln -sf "$PWD/waybar/colors.css" "$CONFIG_DIR/waybar/"
        [ -f "$CONFIG_DIR/waybar/colors.css" ] || cp waybar/colors.css "$CONFIG_DIR/waybar/"
        print_status "Installed waybar/colors.css"
    fi
}

# ============================================================================
# Component: Rofi
# ============================================================================

install_rofi() {
    print_status "Installing Rofi configuration..."

    # Create directory
    mkdir -p "$CONFIG_DIR/rofi"

    # Copy Rofi config
    if [ -f "rofi/config.rasi" ]; then
        [ -L "$CONFIG_DIR/rofi/config.rasi" ] && rm "$CONFIG_DIR/rofi/config.rasi"
        [ -f "$CONFIG_DIR/rofi/config.rasi" ] || ln -sf "$PWD/rofi/config.rasi" "$CONFIG_DIR/rofi/"
        [ -f "$CONFIG_DIR/rofi/config.rasi" ] || cp rofi/config.rasi "$CONFIG_DIR/rofi/"
        print_status "Installed rofi/config.rasi"
    fi
}

# ============================================================================
# Component: Dunst
# ============================================================================

install_dunst() {
    print_status "Installing Dunst notification daemon configuration..."

    # Create directory
    mkdir -p "$CONFIG_DIR/dunst"

    # Copy Dunst config
    if [ -f "dunst/dunstrc" ]; then
        [ -L "$CONFIG_DIR/dunst/dunstrc" ] && rm "$CONFIG_DIR/dunst/dunstrc"
        [ -f "$CONFIG_DIR/dunst/dunstrc" ] || ln -sf "$PWD/dunst/dunstrc" "$CONFIG_DIR/dunst/"
        [ -f "$CONFIG_DIR/dunst/dunstrc" ] || cp dunst/dunstrc "$CONFIG_DIR/dunst/"
        print_status "Installed dunst/dunstrc"
    fi
}

# ============================================================================
# Component: Kitty
# ============================================================================

install_kitty() {
    print_status "Installing Kitty terminal configuration..."

    # Create directory
    mkdir -p "$CONFIG_DIR/kitty"

    # Copy Kitty config
    if [ -f "kitty/kitty.conf" ]; then
        [ -L "$CONFIG_DIR/kitty/kitty.conf" ] && rm "$CONFIG_DIR/kitty/kitty.conf"
        [ -f "$CONFIG_DIR/kitty/kitty.conf" ] || ln -sf "$PWD/kitty/kitty.conf" "$CONFIG_DIR/kitty/"
        [ -f "$CONFIG_DIR/kitty/kitty.conf" ] || cp kitty/kitty.conf "$CONFIG_DIR/kitty/"
        print_status "Installed kitty/kitty.conf"
    fi

    # Copy Kitty colors
    if [ -f "kitty/colors.conf" ]; then
        [ -L "$CONFIG_DIR/kitty/colors.conf" ] && rm "$CONFIG_DIR/kitty/colors.conf"
        [ -f "$CONFIG_DIR/kitty/colors.conf" ] || ln -sf "$PWD/kitty/colors.conf" "$CONFIG_DIR/kitty/"
        [ -f "$CONFIG_DIR/kitty/colors.conf" ] || cp kitty/colors.conf "$CONFIG_DIR/kitty/"
        print_status "Installed kitty/colors.conf"
    fi
}

# ============================================================================
# Component: Matugen
# ============================================================================

install_matugen() {
    print_status "Installing Matugen color schemes..."

    # Create directory
    mkdir -p "$CONFIG_DIR/matugen"

    # Copy all Matugen configuration files
    if [ -d "matugen" ] && [ -n "$(ls -A matugen/* 2>/dev/null)" ]; then
        # Copy all files in matugen/ to $CONFIG_DIR/matugen/
        cp -n matugen/* "$CONFIG_DIR/matugen/" 2>/dev/null || true
        # Remove symlinks and create new ones
        find "$CONFIG_DIR/matugen" -type l -delete
        cp -nsr matugen/* "$CONFIG_DIR/matugen/"
        print_status "Installed Matugen color schemes"
    else
        print_warning "matugen directory not found or empty"
    fi
}

# ============================================================================
# Component: GTK
# ============================================================================

install_gtk() {
    print_status "Installing GTK configuration..."

    # Create GTK directories
    mkdir -p "$CONFIG_DIR/gtk-3.0"
    mkdir -p "$CONFIG_DIR/gtk-4.0"

    # Copy GTK3 config
    if [ -d "gtk" ]; then
        cp -n gtk/* "$CONFIG_DIR/gtk-3.0/" 2>/dev/null || true
    fi

    # Copy GTK4 config
    if [ -d "gtk" ]; then
        cp -n gtk/* "$CONFIG_DIR/gtk-4.0/" 2>/dev/null || true
    fi

    # Apply GTK theme using gsettings if available
    if command_exists gsettings; then
        gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark" 2>/dev/null || true
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" 2>/dev/null || true
        gsettings set org.gnome.desktop.interface icon-theme "Adwaita" 2>/dev/null || true
        print_status "Applied GTK theme settings"
    else
        print_warning "gsettings command not found, skipping theme application"
    fi

    print_status "Installed GTK configuration"
}

# ============================================================================
# Component: Qt
# ============================================================================

install_qt() {
    print_status "Installing Qt theme configuration..."

    # Create Qt directories
    mkdir -p "$CONFIG_DIR/qt5ct"
    mkdir -p "$CONFIG_DIR/qt6ct"

    # Copy Qt5 config
    if [ -d "qt" ]; then
        cp -n qt/* "$CONFIG_DIR/qt5ct/" 2>/dev/null || true
    fi

    # Copy Qt6 config
    if [ -d "qt" ]; then
        cp -n qt/* "$CONFIG_DIR/qt6ct/" 2>/dev/null || true
    fi

    print_status "Installed Qt theme configuration"
}

# ============================================================================
# Component: Fonts
# ============================================================================

install_fonts() {
    print_status "Installing fonts..."

    # Create fonts directory
    mkdir -p "$XDG_DATA_DIR/fonts"

    # Copy fonts if they exist
    if [ -d "fonts" ] && [ -n "$(ls -A fonts 2>/dev/null)" ]; then
        cp -n fonts/* "$XDG_DATA_DIR/fonts/" 2>/dev/null || true
        fc-cache -f 2>/dev/null || true
        print_status "Installed fonts"
    else
        print_warning "fonts directory not found or empty"
    fi
}

# ============================================================================
# Component: Wallpapers
# ============================================================================

install_wallpapers() {
    print_status "Installing wallpapers..."

    # Create pictures directory
    mkdir -p "$HOME/Pictures/wallpapers"

    # Copy wallpapers
    if [ -d "wallpapers" ] && [ -n "$(ls -A wallpapers 2>/dev/null)" ]; then
        cp -n wallpapers/* "$HOME/Pictures/wallpapers/" 2>/dev/null || true
        print_status "Copied wallpapers to ~/Pictures/wallpapers/"
    else
        print_warning "wallpapers directory not found or empty"
    fi
}

# ============================================================================
# Main execution
# ============================================================================

install_all() {
    print_status "Installing all components..."
    install_hypr
    install_waybar
    install_rofi
    install_dunst
    install_kitty
    install_matugen
    install_gtk
    install_qt
    install_fonts
    install_wallpapers
}

# Main execution
main() {
    # Check if we're running as root
    if [ "$EUID" -eq 0 ]; then
        print_error "Please run as yourself, not as root"
        exit 1
    fi

    # Handle no arguments case
    if [ $# -eq 0 ]; then
        install_all
    else
        # Process each argument
        while [ $# -gt 0 ]; do
            case "$1" in
                hypr)
                    install_hypr
                    shift
                    ;;
                waybar)
                    install_waybar
                    shift
                    ;;
                rofi)
                    install_rofi
                    shift
                    ;;
                dunst)
                    install_dunst
                    shift
                    ;;
                kitty)
                    install_kitty
                    shift
                    ;;
                matugen)
                    install_matugen
                    shift
                    ;;
                gtk)
                    install_gtk
                    shift
                    ;;
                qt)
                    install_qt
                    shift
                    ;;
                fonts)
                    install_fonts
                    shift
                    ;;
                wallpapers)
                    install_wallpapers
                    shift
                    ;;
                *)
                    print_error "Unknown option: $1"
                    print_usage
                    exit 1
                    ;;
            esac
        done
    fi

    print_status "Installation complete!"
}

# Run main function with all arguments
main "$@"
