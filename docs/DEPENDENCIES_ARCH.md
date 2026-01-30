# Dependency Analysis for Arch Linux Hyprland Setup

## Core Hyprland Environment

| Package | Required By | Notes |
|---------|-------------|-------|
| **hyprland** | hyprland.conf | Main Wayland compositor |
| **waybar** | waybar/config.json | Status bar |
| **hyprlock** | hypr/hyprlock.conf | Screen locker |
| **hypridle** | hypr/hypridle.conf | Screen idle daemon |
| **hyprshot** | hyprland.conf (bind) | Screenshot tool |
| **rofi** | hyprland.conf | Application launcher (used as MENU) |
| **dunst** | hyprland.conf | Notification daemon |
| **swww** | hyprland.conf (exec-once) | Wallpaper daemon |

## Applications

| Package | Required By | Notes |
|---------|-------------|-------|
| **kitty** | hyprland.conf | Terminal emulator (TERMINAL env var) |
| **nautilus** | hyprland.conf | File manager (FILE_MANAGER env var) |
| **firefox-developer-edition** | hyprland.conf | Web browser (BROWSER env var) |
| **nvim** | Kitty config, hyprland.conf | Text editor (EDITOR env var) |
| **zsh** | kitty.conf | Default shell |

## System Utilities

| Package | Required By | Notes |
|---------|-------------|-------|
| **jq** | hyprland.conf (window management) | JSON processor for hyprctl |
| **wl-clipboard** | hyprland.conf (exec-once) | Wayland clipboard (wl-paste) |
| **cliphist** | hyprland.conf (exec-once) | Clipboard history |
| **brightnessctl** | hyprland.conf (binds) | Brightness control |
| **pulseaudio-utils** | hyprland.conf (binds) | pwvucontrol for audio |
| **pulseaudio** | hyprland.conf | Audio system |
| **network-manager-applet** | hyprland.conf (exec-once) | Network manager applet |
| **gsettings** | hyprland.conf (exec-once) | GTK theme settings |
| **systemctl** | hyprland.conf (exec-once) | User service management |

## Theming

| Package | Required By | Notes |
|---------|-------------|-------|
| **qt5ct** | hyprland.conf (QT_QPA_PLATFORMTHEME) | Qt5 theme configuration |
| **qt6ct** | hyprland.conf (QT_QPA_PLATFORMTHEME) | Qt6 theme configuration |
| **adw-gtk3** | hyprland.conf (GTK_THEME env var) | GTK theme package |
| **matugen** | matugen/ | Color generator |

## Additional Dependencies

| Package | Required By | Notes |
|---------|-------------|-------|
| **rofi** | dunst/dunstrc (as dmenu) | Dmenu interface |
| **notify-send** | test-notifications.sh | Desktop notifications |
| **find** | random_wallpaper.sh | File search |
| **shuf** | random_wallpaper.sh | Random selection |

## Complete Install Script (Arch Linux)

```bash
#!/bin/bash
# Install all dependencies for Hyprland dotfiles

# Update system
sudo pacman -Syu

# Core Hyprland and related packages
sudo pacman -S --needed \
    hyprland \
    xdg-desktop-portal \
    xdg-desktop-portal-hyprland \
    waybar \
    hyprlock \
    hypridle \
    hyprshot \
    rofi \
    dunst \
    swww

# Applications
sudo pacman -S --needed \
    kitty \
    kitty-terminfo \
    kitty-shell-integration \
    nautilus \
    neovim \
    zsh

# Firefox Developer Edition
sudo pacman -S --needed firefox-developer-edition

# System Utilities
sudo pacman -S --needed \
    jq \
    wl-clipboard \
    cliphist \
    brightnessctl \
    pulseaudio \
    pulseaudio-utils \
    network-manager-applet

# Theming
sudo pacman -S --needed \
    qt5ct \
    qt6ct

# Install matugen from AUR
yay -S --needed matugen-bin

# Enable required services
# systemctl --user enable --now pulseaudio
# systemctl --user enable --now pulseaudio-socket
# systemctl --user enable --now pipewire
# systemctl --user enable --now pipewire-pulse
# systemctl --user enable --now hyprpolkitagent
# systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
```

