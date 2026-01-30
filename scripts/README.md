# Scripts

Utility scripts for dotfiles management and system maintenance.

## Installation Scripts

### install.sh
Full installation script for dotfiles and dependencies.

**Usage:**
```bash
./install.sh
```

**Features:**
- Auto-detects system and hostname
- Installs all dotfile components
- Handles dependency management
- Creates necessary directories

### install_dependencies.sh
Installs all required packages for the Hyprland environment.

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

### verify_dependencies.sh
Verifies which dependencies are installed.

**Usage:**
```bash
./verify_dependencies.sh
```

**Features:**
- Checks status of all required packages
- Color-coded output (✓ installed, ✗ missing)
- Identifies installed and missing packages

### check-deps.sh
Quick dependency check for manual review.

**Usage:**
```bash
./check-deps.sh
```

**Features:**
- Fast status check
- Simple output format

### update.sh
Updates dotfiles from the repository.

**Usage:**
```bash
./update.sh
```

**Features:**
- Pulls latest git changes
- Applies chezmoi updates
- Automatic backup before changes

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

- **Install scripts**: Manage dotfiles installation and dependencies
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
