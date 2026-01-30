# Dotfiles

My personal Linux configuration managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

```bash
chezmoi init --apply
```

This will install all configurations to your home directory.

## Components

- **Hyprland**: Wayland compositor
- **Waybar**: Status bar
- **Rofi**: Application launcher
- **Kitty**: Terminal emulator
- **Dunst**: Notifications
- **GTK/Qt**: Theming

## Documentation

- [Full Installation Guide](docs/INSTALL.md)
- [Dependency Management](docs/DEPENDENCY_SCRIPTS.md)

## Scripts

- `scripts/install.sh`: Full setup
- `scripts/verify_dependencies.sh`: Check dependencies
