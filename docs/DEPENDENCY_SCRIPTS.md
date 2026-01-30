# Dependency Management Scripts

This directory contains scripts for managing and verifying Hyprland dotfile dependencies on Arch Linux systems.

## Scripts

### install_dependencies.sh
Installs all required packages for the Hyprland dotfiles.

**Usage:**
```bash
./install_dependencies.sh
```

**Features:**
- Installs core Hyprland stack (hyprland, waybar, hyprlock, hypridle, hyprshot)
- Installs required applications (kitty, nautilus, firefox, nvim, zsh)
- Installs system utilities (jq, wl-clipboard, cliphist, etc.)
- Installs theming packages (adw-gtk3, qt5ct, qt6ct, matugen)
- Installs additional tools (rofi, dunst, swww)
- Automatically detects and uses `yay` or `paru` if available
- Skips already-installed packages

**Requirements:**
- Arch Linux or Arch-based distribution
- Root/sudo access (for package installation)

**Supported Commands:**
```bash
# Just run to install everything
./install_dependencies.sh

# To skip installation, use --help flag
./install_dependencies.sh --help
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/your-repo.git ~/projects/dotfiles
cd ~/projects/dotfiles
```

2. Run the dependency installer:
```bash
chmod +x install_dependencies.sh
./install_dependencies.sh
```

3. Run the verification script to check status:
```bash
```

## Manual Installation

If you prefer to install dependencies manually, use `pacman`:

```bash
# Update system
sudo pacman -Syu

# Install base packages
sudo pacman -S --needed base-devel xorg-server xorg-xinit

# Install Hyprland stack
sudo pacman -S --needed hyprland waybar hyprlock hypridle hyprshot

# Install applications
sudo pacman -S --needed kitty nautilus firefox-developer-edition nvim zsh

# Install system utilities
sudo pacman -S --needed jq wl-clipboard cliphist brightnessctl pulseaudio-utils network-manager-applet

# Install theming packages
sudo pacman -S --needed adw-gtk3 qt5ct qt6ct matugen

# Install additional packages
sudo pacman -S --needed rofi dunst swww
```

## Troubleshooting

### yay not found
If you get an error about `yay` not being found:
```bash
# Option 1: Use paru if available
sudo pacman -S paru
paru -S --needed --noconfirm $(cat <(pacman -Qs | grep -v "^local\|^\d" | awk '{print $2 "-S"}') <(cat <(pacman -Ss | grep -v "^local" | awk '{print $1 "-S"}'))

# Option 2: Install yay manually
sudo pacman -S --needed yay
```

### Permission denied
If you get permission errors:
```bash
chmod +x install_dependencies.sh
sudo pacman -S --needed base-devel
```

## Notes

- All scripts are designed for Arch Linux and Arch-based distributions
- The scripts use `--noconfirm` flag for automatic, non-interactive installation
- Scripts require `sudo` access for package installation
- Optional packages can be installed by modifying the `install_package` function
- Scripts are idempotent - running them multiple times is safe

## Related Documentation

- `DEPENDENCIES_ARCH.md` - Detailed package list and installation instructions
- `INSTALL_REFACTORING.md` - Installation script refactoring documentation
- `bootstrap.sh` - One-command setup for chezmoi
