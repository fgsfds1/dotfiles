#!/usr/bin/env bash
# Dependency verification script for Arch Linux
# Checks which dependencies are installed and which ones are missing

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print functions
print_status() { echo -e "${GREEN}[+]${NC} $1"; }
print_error() { echo -e "${RED}[-]${NC} $1"; }
print_warning() { echo -e "${YELLOW} [!] $1"; }

# Check if a command/package exists
check_package() {
    pacman -Qi "$1" &>/dev/null
}

# Check if a command is available
check_command() {
    command -v "$1" &>/dev/null
}

# Get package status
get_package_status() {
    if check_package "$1"; then
        if pacman -Qi "$1" &>/dev/null | grep -q "Installed\|Installed (Local)" 2>/dev/null; then
            echo "installed"
        else
            echo "not_installed"
        fi
    else
        echo "not_installed"
    fi
}

# Main verification function
main() {
    echo -e "${BLUE}========================================"
    echo "   Hyprland Dotfiles - Dependency Check"
    echo "========================================${NC}"
    echo ""

    # Check for pacman
    if ! command -v pacman &>/dev/null; then
        echo -e "${RED}Error: pacman not found. This script requires pacman-based system.${NC}"
        exit 1
    fi

    echo -e "${BLUE}Checking packages...${NC}"
    echo ""

    # Core Hyprland packages
    echo -e "${BLUE}Core Hyprland:${NC}"
    for package in "hyprland" "waybar" "hyprlock" "hypridle" "hyprshot"; do
        status=$(get_package_status "$package")
        case $status in
            "installed")
                echo -e "  ${GREEN}✓${NC} $package"
                ;;
            "not_installed")
                echo -e "  ${RED}✗${NC} $package ${RED}(missing)${NC}"
                ;;
        esac
    done

    echo ""
    echo -e "${BLUE}Applications:${NC}"
    for package in "kitty" "nautilus" "firefox-developer-edition" "nvim" "zsh"; do
        status=$(get_package_status "$package")
        case $status in
            "installed")
                echo -e "  ${GREEN}✓${NC} $package"
                ;;
            "not_installed")
                echo -e "  ${RED}✗${NC} $package ${RED}(missing)${NC}"
                ;;
        esac
    done

    echo ""
    echo -e "${BLUE}System Utilities:${NC}"
    for package in "jq" "wl-clipboard" "cliphist" "brightnessctl" "pulseaudio-utils" "network-manager-applet"; do
        status=$(get_package_status "$package")
        case $status in
            "installed")
                echo -e "  ${GREEN}✓${NC} $package"
                ;;
            "not_installed")
                echo -e "  ${RED}✗${NC} $package ${RED}(missing)${NC}"
                ;;
        esac
    done

    echo ""
    echo -e "${BLUE}Theming Packages:${NC}"
    for package in "adw-gtk3" "qt5ct" "qt6ct" "matugen"; do
        status=$(get_package_status "$package")
        case $status in
            "installed")
                echo -e "  ${GREEN}✓${NC} $package"
                ;;
            "not_installed")
                echo -e "  ${RED}✗${NC} $package ${RED}(missing)${NC}"
                ;;
        esac
    done

    echo ""
    echo -e "${BLUE}Additional Packages:${NC}"
    for package in "rofi" "dunst" "swww"; do
        status=$(get_package_status "$package")
        case $status in
            "installed")
                echo -e "  ${GREEN}✓${NC} $package"
                ;;
            "not_installed")
                echo -e "  ${RED}✗${NC} $package ${RED}(missing)${NC}"
                ;;
        esac
    done

    echo ""
    echo -e "${BLUE}Checking commands...${NC}"

    # Check for commands
    check_command "kitty" && echo -e "  ${GREEN}✓${NC} kitty command found" || echo -e "  ${RED}✗${NC} kitty command not found"
    check_command "nautilus" && echo -e "  ${GREEN}✓${NC} nautilus command found" || echo -e "  ${RED}✗${NC} nautilus command not found"
    check_command "hyprctl" && echo -e "  ${GREEN}✓${NC} hyprctl command found" || echo -e "  ${RED}✗${NC} hyprctl command not found"
    check_command "gsettings" && echo -e "  ${GREEN}✓${NC} gsettings command found" || echo -e "  ${YELLOW} [!]${NC} gsettings command not found (optional)"
    check_command "gsettings" && echo -e "  ${GREEN}✓${NC} gsettings command found" || echo -e "  ${YELLOW} [!]${NC} gsettings command not found (optional)"

    echo ""
    echo -e "========================================"
    echo -e "    ${GREEN}Check complete!${NC}"
    echo -e "========================================"
}

# Run main function
main "$@"
