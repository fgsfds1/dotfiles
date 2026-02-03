#!/usr/bin/env bash
# Dependency installer for Arch Linux and derivatives
# Installs all required packages for Hyprland dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Pacman options
PACMAN="sudo pacman -S --noconfirm"
YAY="yay -S --noconfirm"

# Print functions
print_status() { echo -e "${GREEN}[+]${NC} $1"; }
print_error() { echo -e "${RED}[-]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please run as yourself, not as root"
    exit 1
fi

# Check if yay is installed, if not suggest installing it
check_yay() {
    if ! command -v yay &>/dev/null; then
        print_warning "yay not found. Installing yay first..."
        if command -v paru &>/dev/null; then
            print_status "Using paru instead of yay"
            YAY="paru -S --noconfirm"
        else
            print_warning "yay not found. Installing yay via pacman..."
            sudo pacman -S --noconfirm yay
        fi
    fi
}

# Install a package if not already installed
install_package() {
    local package="$1"
    if pacman -Qi "$package" &>/dev/null; then
        print_status "$package is already installed"
    else
        echo "Installing $package..."
        sudo pacman -S --noconfirm "$package"
    fi
}

# Main installation function
main() {
    print_status "Starting dependency installation..."

    # Check for required tools
    command -v pacman &>/dev/null || { echo "Error: pacman not found. This script requires pacman."; exit 1; }

    # Install base packages
    print_status "Installing base packages..."
    sudo pacman -Sy --noconfirm base-devel xorg-server xorg-xinit

    # Install Hyprland stack
    print_status "Installing Hyprland stack..."
    install_package "hyprland"
    install_package "waybar"
    install_package "hyprlock"
    install_package "hypridle"
    install_package "hyprshot"

    # Install applications
    print_status "Installing applications..."
    install_package "kitty"
    install_package "nautilus"
    install_package "helium-browser-bin"
    install_package "nvim"
    install_package "zsh"

    # Install system utilities
    print_status "Installing system utilities..."
    install_package "jq"
    install_package "wl-clipboard"
    install_package "cliphist"
    install_package "brightnessctl"
    install_package "pulseaudio-utils"
    install_package "network-manager-applet"

    # Install theming packages
    print_status "Installing theming packages..."
    install_package "adw-gtk3"
    install_package "qt5ct"
    install_package "qt6ct"
    install_package "matugen"

    # Install additional packages
    print_status "Installing additional packages..."
    install_package "rofi"
    install_package "dunst"
    install_package "swww"

    print_status "All dependencies installed successfully!"
}

# Run main function
main "$@"
