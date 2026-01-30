# Dotfiles

Personal Hyprland setup managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

```bash
# Install chezmoi if needed
pacman -S chezmoi

# Setup
chezmoi init --apply

# Update configs
chezmoi update
```

## Components

- **Hyprland**: Compositor, lock screen, idle
- **Waybar**: Status bar with colors
- **Rofi**: Application launcher
- **Kitty**: Terminal emulator
- **Dunst**: Notifications
- **GTK/Qt**: Theme configuration
- **Matugen**: Color schemes

## Usage

### Edit Configs

```bash
# Edit source state
chezmoi edit ~/.config/hypr/hyprland.conf

# Preview changes
chezmoi diff

# Apply changes
chezmoi apply
```

### Scripts

- `bootstrap.sh`: Quick setup
- `install_dependencies.sh`: Arch dependencies
- `random_wallpaper.sh`: Wallpapers
- `test-notifications.sh`: Test notifications

## Assets

- **fonts/**: Input MonoNarrow terminal fonts
- **wallpapers/**: Personal wallpapers for swww

## Structure

```
chezmoi/              # chezmoi source state
scripts/              # Utility scripts
assets/               # Fonts and wallpapers
docs/                 # Documentation
```

## Git Workflow

```bash
# Navigate to chezmoi source
chezmoi cd

# Edit configs
nano chezmoi/dot_hypr/hyprland.conf

# Preview and apply
chezmoi diff
chezmoi apply

# Commit changes
git add .
git commit -m "Update config"
git push
```
