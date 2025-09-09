#!/usr/bin/env bash
# Script to switch between different Hyprland configurations

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
    echo -e "${BLUE}Hyprland Configuration Switcher${NC}"
    echo
    echo "Usage: $0 [machine-name]"
    echo
    echo "Available configurations:"
    for dir in */; do
        if [[ -f "${dir}hyprland.conf" ]]; then
            echo "  - ${dir%/}"
        fi
    done
    echo
    echo "Examples:"
    echo "  $0 aya     # Switch to aya configuration"
    echo "  $0 rin     # Switch to rin configuration"
    echo "  $0         # Show current configuration"
}

# Check if config directory exists
CONFIG_DIR="$HOME/.config/hypr"
if [[ ! -d "$CONFIG_DIR" ]]; then
    print_error "Hyprland config directory not found: $CONFIG_DIR"
    print_status "Run ./install.sh first to set up configurations"
    exit 1
fi

# Show current config if no arguments
if [[ $# -eq 0 ]]; then
    if [[ -f "$CONFIG_DIR/hyprland.conf" ]]; then
        current=$(head -1 "$CONFIG_DIR/hyprland.conf" | grep -o '[a-zA-Z]*' | head -1 || echo "unknown")
        print_status "Current configuration: $current"
        
        # Show source line from config
        source_line=$(grep "^source" "$CONFIG_DIR/hyprland.conf" 2>/dev/null || echo "No source found")
        if [[ "$source_line" != "No source found" ]]; then
            print_status "Config source: $source_line"
        fi
    else
        print_warning "No Hyprland configuration found"
    fi
    echo
    print_help
    exit 0
fi

MACHINE="$1"

# Validate machine configuration exists
if [[ ! -f "$MACHINE/hyprland.conf" ]]; then
    print_error "Configuration not found for machine: $MACHINE"
    echo
    print_help
    exit 1
fi

# Backup current config
if [[ -f "$CONFIG_DIR/hyprland.conf" ]]; then
    backup_file="$CONFIG_DIR/hyprland.conf.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$CONFIG_DIR/hyprland.conf" "$backup_file"
    print_status "Backed up current config to: $backup_file"
fi

# Copy new configuration
cp "$MACHINE/hyprland.conf" "$CONFIG_DIR/hyprland.conf"
print_status "✓ Switched to $MACHINE configuration"

# Check if Hyprland is running and offer to reload
if pgrep -x "Hyprland" >/dev/null; then
    print_warning "Hyprland is currently running"
    echo -n "Would you like to reload the configuration? [y/N]: "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        # Send reload signal to Hyprland
        hyprctl reload >/dev/null 2>&1 && print_status "✓ Configuration reloaded" || print_warning "Failed to reload automatically"
    else
        print_status "Configuration will take effect on next Hyprland restart"
    fi
else
    print_status "Configuration ready for next Hyprland start"
fi

print_status "Active configuration: $MACHINE"

