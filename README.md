# Dotfiles Configuration

A collection of system configurations and dotfiles, featuring a comprehensive NixOS setup with native program configurations.

## Repository Structure

This repository is organized into the following sections:

- **`nixos/`** - Complete NixOS system configuration using flakes (not updated)
- **`hyprland/`** - Native Hyprland configuration files (extracted from NixOS)
- **`kitty/`** - Native Kitty configuration files

---

## NixOS Configuration (`nixos/`) (not updated)

The NixOS directory contains a complete system configuration with the following key features:

- **Flake-based configuration** for reproducible builds
- **Multi-machine support** (aya and rin)
- **Hyprland** as the primary window manager
- **Home Manager** integration for user-specific configurations
- **Per-machine customization** with shared base configurations

### Machine Configurations

### 🖥️ Aya (ThinkPad E14 AMD)
- **Monitor Scale**: 1.25x (HiDPI)
- **Hardware**: Lenovo ThinkPad E14 AMD with Bluetooth
- **Special Features**: Blueman applet for Bluetooth management

### 🖥️ Rin
- **Monitor Scale**: 1.0x (Standard DPI)  
- **Configuration**: SSH enabled with password authentication

---

## Native Hyprland Configuration (`hyprland/`)

The `hyprland/` directory contains native Hyprland configuration files extracted from the NixOS setup. These configurations can be used on any Linux distribution with Hyprland installed.

### Quick Start

```bash
cd hyprland/

# Check dependencies
./check-deps.sh

# Install configuration (auto-detects hostname)
./install.sh

# Or install specific machine config
./install.sh aya     # For ThinkPad with HiDPI
./install.sh rin     # For standard DPI setup
./install.sh utsuho  # For main desktop PC
```

### Key Scripts

- **`install.sh`** - One-click installation with hostname detection
- **`switch-config.sh`** - Switch between machine configurations
- **`validate-config.sh`** - Validate configuration syntax
- **`check-deps.sh`** - Check for required dependencies

For detailed information, see [`hyprland/README.md`](hyprland/README.md).
---