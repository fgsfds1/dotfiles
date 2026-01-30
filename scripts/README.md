# Scripts

Utility scripts for dotfiles management and system maintenance.

## Installation Scripts

### bootstrap.sh
One-command setup script for chezmoi dotfiles.

**Usage:**
```bash
./bootstrap.sh
```

**Features:**
- Auto-installs chezmoi if not present
- Initializes chezmoi with current repository
- Applies all configurations
- Sets up git remote and commits initial state

### install_dependencies.sh
Installs all required packages for the Hyprland environment (Arch Linux and derivatives).

**Usage:**
```bash
./install_dependencies.sh
```

**Features:**
- Uses pacman (Arch-based)
- Auto-detects yay or paru for AUR packages
- Skips already-installed packages
- Handles core Hyprland stack
- Installs applications and system utilities
- Sets up theming packages

## Utility Scripts

### random_wallpaper.sh
Random wallpaper selector and setter.

**Usage:**
```bash
./random_wallpaper.sh
```

**Features:**
- Scans ~/Pictures/wallpapers
- Randomly selects wallpaper
- Sets wallpaper using swww
- Logs selection to history

**TODO**: Update hardcoded paths for generic use

### test-notifications.sh
Test notification daemon configuration.

**Usage:**
```bash
./test-notifications.sh
```

**Features:**
- Sends test notifications
- Verifies dunst is running
- Tests various notification types

## Script Organization

- **Setup scripts**: Manage initial installation and chezmoi setup
- **Dependency scripts**: Package installation for specific systems
- **Utility scripts**: Perform specific tasks or maintenance
- **All scripts**: Executable with proper shebangs (`#!/usr/bin/env bash`)

## Requirements

All scripts require:
- Bash shell
- Appropriate permissions (chmod +x)
- Proper dependencies installed (for install scripts)

## Safety

- All scripts use `set -e` for error handling
- No destructive operations without confirmation
- Clear error messages and status indicators
