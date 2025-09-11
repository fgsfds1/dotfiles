# Native Hyprland Configuration

This directory contains native Hyprland configuration files extracted from the NixOS setup. These configurations can be used on any system with Hyprland installed.

## 📁 Directory Structure

```
hyprland/
├── README.md              # This file
├── install.sh             # Installation script
├── common/
│   └── hyprland.conf      # Shared Hyprland configuration
├── aya/
│   └── hyprland.conf      # ThinkPad E14 AMD (HiDPI) config
├── rin/
│   └── hyprland.conf      # Standard DPI config
├── utsuho/
│   └── hyprland.conf      # Main desktop PC config
├── waybar/
│   ├── config.json        # Waybar configuration
│   └── style.css          # Waybar styling
├── rofi/
│   └── config.rasi        # Application launcher configuration
├── dunst/
│   └── dunstrc            # Notification daemon configuration
└── hyprlock/
    └── hyprlock.conf      # Screen lock configuration
```

## 🚀 Quick Installation

```bash
# Auto-detect hostname and install
./install.sh

# Or specify machine configuration
./install.sh aya     # For ThinkPad with HiDPI
./install.sh rin     # For standard DPI setup  
./install.sh utsuho  # For main desktop PC
```

## ⚙️ Configuration Details

### Machine-Specific Settings

#### Aya (ThinkPad E14 AMD)
- **Monitor scaling**: 1.25x (HiDPI)
- **Wallpaper**: `wp_aya.jpg`
- **Extra startup**: Blueman applet for Bluetooth

#### Rin
- **Monitor scaling**: 1.0x (standard)
- **Wallpaper**: `wp_rin.jpg`
- **Minimal startup**: Just wallpaper

#### Utsuho (Main Desktop PC)
- **Dual monitors**: 27" 1440p@180Hz (main, 1.2x scaling) + 24" 1440p@75Hz (secondary, 1.0x scaling)
- **Wallpaper**: `wp_utsuho.jpg`
- **Optimizations**: Enhanced visual effects, VRR support, gaming window rules
- **Special**: F24 Discord push-to-talk passthrough

### Key Features

#### Window Management
- **Layout**: Dwindle with smart gaps
- **Borders**: Cyan-to-green gradient for active windows
- **Opacity**: Active windows 100%, inactive 90%
- **Animations**: Smooth bezier curves

#### Keybindings
| Shortcut | Action |
|----------|--------|
| `Super + Return` | Terminal (Kitty) |
| `Super + E` | File Manager (Thunar) |
| `Super + B` | Browser (Firefox) |
| `Super + R/T` | App Launcher (Rofi) |
| `Super + Q` | Close Window |
| `Super + F` | Toggle Floating |
| `Super + ;` | Lock Screen |
| `Print` | Screenshot (region) |

#### Input Configuration
- **Keyboard**: US/Russian with Caps Lock toggle
- **Mouse**: Flat acceleration profile for Logitech Pebble
- **Touchpad**: Disabled by default

#### Notifications
- **Daemon**: Dunst with modern styling
- **Theme**: Dark with accent colors matching window borders
- **Position**: Top-right corner with rounded corners
- **Features**: Progress bars, icons, action buttons, history

#### Theming
- **Qt**: Fusion style with qt5ct and custom dark color scheme
- **GTK**: Adwaita dark theme
- **Icons**: Adwaita icon theme
- **Wayland**: Native Qt and GTK support with proper scaling

#### Environment
- **Cursor size**: 64px
- **Screenshot directory**: `~/Pictures/screenshots`
- **Electron scaling**: Enabled for Wayland apps

## 📦 Dependencies

### Required Packages
```bash
# Core Hyprland
hyprland

# Status bar and system tray
waybar

# Wallpaper management
swww

# Screen locking
hyprlock

# Application launcher
rofi-wayland

# Notifications
dunst

# Qt/GTK theming
qt5ct

# Terminal
kitty

# File manager
thunar

# Network management
networkmanager
network-manager-applet

# Audio control
wireplumber
pavucontrol

# Brightness control
brightnessctl

# Screenshot tool
hyprshot
```

### Optional Packages
```bash
# Bluetooth management (for aya)
blueman

# Additional applications
firefox
```

## 🎨 Customization

### Adding a New Machine

1. **Create machine directory**:
   ```bash
   mkdir newmachine
   ```

2. **Create machine-specific config**:
   ```bash
   cp aya/hyprland.conf newmachine/hyprland.conf
   ```

3. **Edit the configuration**:
   ```bash
   # Edit monitor scaling and wallpaper
   nano newmachine/hyprland.conf
   ```

### Wallpaper Setup

1. **Place wallpapers** in `~/Pictures/wallpapers/`
2. **Update machine config** to reference correct wallpaper:
   ```
   exec-once = swww img ~/Pictures/wallpapers/your_wallpaper.jpg
   ```

### Waybar Customization

- **Config**: Edit `waybar/config.json` for modules and layout
- **Styling**: Edit `waybar/style.css` for appearance

### Lock Screen Customization

- **Background**: Change wallpaper path in `hyprlock/hyprlock.conf`
- **Colors**: Modify input field colors and effects

## 🔧 Manual Installation

If you prefer manual installation:

```bash
# Create config directories
mkdir -p ~/.config/hypr/common
mkdir -p ~/.config/waybar

# Copy common config
cp common/hyprland.conf ~/.config/hypr/common/

# Copy machine-specific config (replace 'aya' with your machine)
cp aya/hyprland.conf ~/.config/hypr/hyprland.conf

# Copy waybar config
cp waybar/config.json ~/.config/waybar/config
cp waybar/style.css ~/.config/waybar/style.css

# Copy lock screen config
cp hyprlock/hyprlock.conf ~/.config/hypr/

# Copy wallpapers
mkdir -p ~/Pictures/wallpapers
# Copy your wallpapers here
```

## 🐛 Troubleshooting

### Common Issues

1. **Hyprland won't start**
   - Check that all dependencies are installed
   - Verify graphics drivers are properly installed
   - Check Hyprland logs: `journalctl -f -u display-manager`

2. **Waybar not showing**
   - Ensure waybar is installed
   - Check config syntax: `waybar --config ~/.config/waybar/config`

3. **Wallpaper not loading**
   - Install `swww` package
   - Verify wallpaper path exists
   - Check if `swww init` runs successfully

4. **Lock screen issues**
   - Install `hyprlock` package
   - Verify wallpaper path in config
   - Check PAM configuration

### Performance Optimization

For better performance on older hardware:
- Reduce blur passes in decorations
- Disable animations
- Lower monitor refresh rate
- Reduce shadow effects

## 🔄 Syncing with NixOS Config

To keep this native config in sync with the NixOS version:

1. **Extract changes** from `../nixos/hyprland/` when updated
2. **Convert Nix syntax** to native configuration format
3. **Test configurations** on target machines
4. **Update documentation** as needed

---

*This configuration provides a modern, efficient Hyprland setup that can be easily deployed across different machines and environments.*

