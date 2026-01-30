# Dotfiles Installation Guide

## Overview

This repository manages your dotfiles using **chezmoi**, a modern dotfiles manager that stores your configuration state in a version-controlled repository and automatically applies it to your home directory.

## Quick Start

### Install chezmoi

If not already installed:

```bash
# Arch Linux
pacman -S chezmoi

# Or one-line install
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Initialize and Apply

```bash
# From this repository
chezmoi init --apply

# Or from GitHub (if you've pushed)
chezmoi init --apply https://github.com/yourusername/dotfiles
```

## Components

### Core Configuration

- **hypr/**: Hyprland compositor, lock screen, and idle settings
- **waybar/**: Status bar with colors and styling
- **rofi/**: Application launcher configuration
- **dunst/**: Notification daemon configuration
- **kitty/**: Terminal emulator settings and colors
- **gtk/**: GTK 3.0 and 4.0 theme configuration
- **qt/**: Qt5/Qt6 theme settings
- **matugen/**: Color scheme generator configurations

### Assets

- **fonts/**: Personal font files for terminal
- **wallpapers/**: Wallpaper images

### Scripts

- **scripts/bootstrap.sh**: One-command setup for chezmoi
- **scripts/install_dependencies.sh**: Package dependency installation (Arch Linux and derivatives)
- **scripts/random_wallpaper.sh**: Random wallpaper selector and setter
- **scripts/test-notifications.sh**: Test notification system

## Installation

### Full Installation

```bash
cd ~/projects/dotfiles
chezmoi init --apply
```

### Install Specific Components

```bash
# Apply only Hyprland configs
chezmoi apply dot_hypr

# Apply only Waybar configs
chezmoi apply dot_waybar

# Apply everything
chezmoi apply
```

### Update Configuration

```bash
# Pull latest changes and apply
chezmoi update

# Or manually
chezmoi init --apply https://github.com/yourusername/dotfiles
```

## Dependency Management

### Install All Dependencies

```bash
cd ~/projects/dotfiles/scripts
./install_dependencies.sh
```

### Modifying Configurations

### Edit Source State

```bash
# Edit a specific config file
chezmoi edit ~/.config/hypr/hyprland.conf

# Edit chezmoi source directly
chezmoi edit chezmoi/dot_hypr/hyprland.conf
```

### Preview Changes

```bash
# Show what would be changed
chezmoi diff

# Show diff for specific file
chezmoi diff ~/.config/hypr/hyprland.conf
```

### Add New Configs

```bash
# Add a file to chezmoi
chezmoi add ~/.config/your-app/config

# Add a directory
chezmoi add ~/.config/your-app/
```

## Chezmoi Commands

| Command | Description |
|---------|-------------|
| `chezmoi init [repo]` | Initialize chezmoi source state |
| `chezmoi add [target]` | Add file to source state |
| `chezmoi edit [target]` | Edit source state |
| `chezmoi diff [target]` | Show differences |
| `chezmoi apply [target]` | Apply changes |
| `chezmoi update` | Pull and apply latest |
| `chezmoi cd` | Open shell in source directory |
| `chezmoi data` | Show template data |
| `chezmoi edit-config-template` | Edit chezmoi config template |

## Templates

chezmoi supports Go templates for machine-specific configurations. Available template data:

```bash
# See all available data
chezmoi data
```

Common uses:
- Different configs for different machines
- OS-specific settings
- User-specific preferences

Example template:
```bash
# ~/.config/zsh/.zshrc
{% if .chezmoi.hostname == "my-laptop" %}
export EDITOR=nvim
{% else %}
export EDITOR=vim
{% endif %}
```

## Secrets Management

chezmoi supports secure secret management with password managers and encryption:

### 1Password Integration

```bash
chezmoi init --use-secrets=1password
```

### Age Encryption

```bash
# Encrypt a file
chezmoi add --encrypt ~/.ssh/id_rsa
```

### Git-Crypt

```bash
chezmoi add --encrypt ~/.config/yourapp/secret.json
```

See [chezmoi documentation](https://www.chezmoi.io/user-guide/secrets/) for more details.

## Troubleshooting

### chezmoi not found

```bash
# Install chezmoi
pacman -S chezmoi
```

### Permission errors

```bash
# Ensure chezmoi is in your PATH
export PATH="$PATH:$(chezmoi data | jq -r '.chezmoi.executable')"
```

### Apply fails

```bash
# Check what would change
chezmoi diff

# Dry run
chezmoi apply --dry-run

# Force apply (careful!)
chezmoi apply --force
```

### Config files not updating

```bash
# Force re-apply
chezmoi apply --force

# Check current state
chezmoi status
```

## Structure

```
dotfiles/
├── chezmoi/              # chezmoi source state (dot_* files)
│   ├── dot_hypr/
│   ├── dot_waybar/
│   ├── dot_rofi/
│   ├── dot_dunst/
│   ├── dot_kitty/
│   ├── dot_gtk/
│   ├── dot_qt/
│   └── dot_matugen/
├── scripts/              # Installation and utility scripts
├── assets/               # Font files and wallpapers
├── docs/                 # Documentation
└── README.md            # This file
```

## Contributing

When adding new dotfiles:

1. Add files to `chezmoi/` directory
2. Run `chezmoi add` for each file/directory
3. Commit changes to git
4. Push to remote

## Links

- [chezmoi Documentation](https://www.chezmoi.io/)
- [chezmoi GitHub](https://github.com/twpayne/chezmoi)
- [Quick Start Guide](https://www.chezmoi.io/quick-start/)

## License

MIT
