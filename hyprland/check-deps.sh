#!/usr/bin/env bash
# Script to check for required dependencies

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

print_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

check_command() {
    local cmd="$1"
    local desc="$2"
    local required="$3"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        print_success "✓ $desc ($cmd) - available"
        # Only check version for safe commands (avoid GUI apps that might hang)
        if [[ "$cmd" == "hyprland" ]] || [[ "$cmd" == "Hyprland" ]]; then
            local version=$(timeout 2s $cmd --version 2>/dev/null | head -1 || echo "version check failed")
            print_status "  Version info: $version"
        fi
    else
        if [[ "$required" == "true" ]]; then
            print_error "✗ $desc ($cmd) - REQUIRED but not found"
            return 1
        else
            print_warning "○ $desc ($cmd) - optional, not found"
        fi
    fi
    return 0
}

check_package_manager() {
    echo -e "${BLUE}Package Manager Detection${NC}"
    echo "========================="
    
    if command -v pacman >/dev/null 2>&1; then
        print_status "Detected: Arch Linux (pacman)"
        return 0
    elif command -v apt >/dev/null 2>&1; then
        print_status "Detected: Debian/Ubuntu (apt)"
        return 1
    elif command -v dnf >/dev/null 2>&1; then
        print_status "Detected: Fedora (dnf)"
        return 2
    elif command -v nix-env >/dev/null 2>&1; then
        print_status "Detected: NixOS/Nix (nix)"
        return 3
    else
        print_warning "Unknown package manager"
        return 99
    fi
}

show_install_commands() {
    local pm="$1"
    
    echo
    echo -e "${BLUE}Installation Commands${NC}"
    echo "===================="
    
    case $pm in
        0) # Arch Linux
            echo "# Core Hyprland packages:"
            echo "sudo pacman -S hyprland waybar swww hyprlock rofi-wayland dunst"
            echo "sudo pacman -S kitty dolphin firefox"
            echo "sudo pacman -S networkmanager network-manager-applet"
            echo "sudo pacman -S wireplumber pavucontrol brightnessctl"
            echo ""
            echo "# AUR packages:"
            echo "yay -S hyprshot"
            echo ""
            echo "# Optional:"
            echo "sudo pacman -S blueman"
            ;;
        1) # Debian/Ubuntu
            echo "# Note: Hyprland may not be available in standard repos"
            echo "# Check https://hyprland.org/Installation/ for instructions"
            echo ""
            echo "# Available packages:"
            echo "sudo apt install rofi dunst kitty dolphin firefox-esr"
            echo "sudo apt install network-manager network-manager-gnome"
            echo "sudo apt install pavucontrol brightnessctl"
            echo "sudo apt install blueman"
            ;;
        2) # Fedora
            echo "# Enable COPR for Hyprland:"
            echo "sudo dnf copr enable solopasha/hyprland"
            echo "sudo dnf install hyprland waybar swww hyprlock"
            echo "sudo dnf install rofi dunst kitty dolphin firefox"
            echo "sudo dnf install NetworkManager-applet"
            echo "sudo dnf install pavucontrol brightnessctl blueman"
            ;;
        3) # NixOS
            print_status "You're using NixOS - use the configuration in ../nixos/ instead!"
            ;;
        *) # Unknown
            echo "Please install the following packages using your system's package manager:"
            echo "- hyprland, waybar, swww, hyprlock, rofi, dunst"
            echo "- kitty, dolphin, firefox"
            echo "- network-manager-applet, pavucontrol, brightnessctl"
            ;;
    esac
}

main() {
    echo -e "${BLUE}Hyprland Dependencies Checker${NC}"
    echo "=============================="
    echo
    
    local errors=0
    
    # Core requirements
    echo -e "${BLUE}Core Requirements${NC}"
    echo "-----------------"
    check_command "Hyprland" "Hyprland compositor" "true" || errors=$((errors + 1))
    check_command "waybar" "Status bar" "true" || errors=$((errors + 1))
    check_command "swww" "Wallpaper daemon" "true" || errors=$((errors + 1))
    check_command "hyprlock" "Screen locker" "true" || errors=$((errors + 1))
    check_command "rofi" "Application launcher" "true" || errors=$((errors + 1))
    check_command "dunst" "Notification daemon" "true" || errors=$((errors + 1))
    echo
    
    # Applications
    echo -e "${BLUE}Applications${NC}"
    echo "------------"
    check_command "kitty" "Terminal emulator" "true" || errors=$((errors + 1))
    check_command "dolphin" "File manager" "false"
    check_command "firefox" "Web browser" "false"
    echo
    
    # System utilities
    echo -e "${BLUE}System Utilities${NC}"
    echo "----------------"
    check_command "nm-applet" "Network manager applet" "true" || errors=$((errors + 1))
    check_command "pavucontrol" "Audio control" "false"
    check_command "brightnessctl" "Brightness control" "false"
    check_command "hyprshot" "Screenshot tool" "false"
    echo
    
    # Optional
    echo -e "${BLUE}Optional Components${NC}"
    echo "-------------------"
    check_command "blueman-applet" "Bluetooth manager" "false"
    check_command "wpctl" "Wireplumber control" "false"
    echo
    
    # Check for config files
    echo -e "${BLUE}Configuration Files${NC}"
    echo "-------------------"
    if [[ -f "common/hyprland.conf" ]]; then
        print_success "✓ Common Hyprland configuration"
    else
        print_error "✗ Common configuration missing"
        errors=$((errors + 1))
    fi
    
    if [[ -f "waybar/config.json" ]]; then
        print_success "✓ Waybar configuration"
    else
        print_error "✗ Waybar configuration missing"
        errors=$((errors + 1))
    fi
    
    local machine_configs=0
    for dir in */; do
        if [[ -f "${dir}hyprland.conf" ]] && [[ "$dir" != "common/" ]]; then
            machine_configs=$((machine_configs + 1))
        fi
    done
    
    if [[ $machine_configs -gt 0 ]]; then
        print_success "✓ Found $machine_configs machine configuration(s)"
    else
        print_warning "○ No machine-specific configurations found"
    fi
    echo
    
    # Package manager detection and install commands
    check_package_manager
    local pm_type=$?
    show_install_commands $pm_type
    
    echo
    echo "=============================="
    if [[ $errors -eq 0 ]]; then
        print_success "All required dependencies are available!"
        print_status "Run ./install.sh to set up configurations"
    else
        print_error "Missing $errors required dependencies"
        print_status "Install missing packages and run this script again"
        exit 1
    fi
}

main "$@"

