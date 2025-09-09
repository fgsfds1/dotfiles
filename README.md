# Dotfiles Configuration

A collection of system configurations and dotfiles, featuring a comprehensive NixOS setup with native program configurations.

## Repository Structure

This repository is organized into the following sections:

- **`nixos/`** - Complete NixOS system configuration using flakes
- **`hyprland/`** - Native Hyprland configuration files (extracted from NixOS)
- **Future**: Additional native program configuration files (planned)

---

## NixOS Configuration (`nixos/`)

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
- **Wallpaper**: `wp_aya.jpg`

### 🖥️ Rin
- **Monitor Scale**: 1.0x (Standard DPI)  
- **Wallpaper**: `wp_rin.jpg`
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

### Features

- **Multi-machine support** with automatic hostname detection
- **Modular configuration** with shared common settings
- **Easy switching** between machine configurations
- **Configuration validation** and dependency checking
- **Complete documentation** and installation scripts

### Key Scripts

- **`install.sh`** - One-click installation with hostname detection
- **`switch-config.sh`** - Switch between machine configurations
- **`validate-config.sh`** - Validate configuration syntax
- **`check-deps.sh`** - Check for required dependencies

### Machine Configurations

- **Aya**: ThinkPad E14 AMD with 1.25x scaling and Bluetooth
- **Rin**: Standard DPI setup with minimal configuration
- **Utsuho**: Main desktop PC with dual 1440p monitors and gaming optimizations

For detailed information, see [`hyprland/README.md`](hyprland/README.md).

---

## Future Plans: Additional Native Configuration Files

The repository will be expanded to include native program configuration files alongside the NixOS setup. This will provide:

### Planned Structure
- **`shell/`** - Shell configurations (zsh, bash, aliases)
- **`editors/`** - Editor configurations (nvim, emacs configs)
- **`terminals/`** - Terminal emulator configs (kitty, alacritty)
- **`wm/`** - Window manager configs (hyprland, waybar, rofi)
- **`applications/`** - Application-specific configs (git, firefox user.js, etc.)

### Benefits of Native Configs
- **Cross-platform compatibility** - Use configs on non-NixOS systems
- **Direct configuration** - Traditional dotfile management approach
- **Easier sharing** - Individual configs can be shared independently
- **Learning reference** - Compare NixOS vs native configuration approaches

### Integration Strategy
The native configs will complement the NixOS setup by:
- Providing fallback configurations for non-NixOS environments
- Serving as reference implementations for manual setup
- Enabling hybrid approaches (NixOS + some native configs)
- Supporting development on different systems

---

*Configuration optimized for development workflow with modern desktop environment features.*