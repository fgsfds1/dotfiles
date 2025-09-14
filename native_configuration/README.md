# Native Desktop Configuration

This directory contains native desktop configuration files extracted from the NixOS setup. These configurations provide a complete Hyprland-based desktop environment that can be used on any system with Hyprland installed.

# TODO

- [] network control
- [] sound devices control
- [] wallpaper and theme change script
- [] theming for non-qt non-gtk apps (via color configs via matugen)
- [x] theming for gtk (via matugen) - ✅ GTK 3.0/4.0 Material Design colors implemented
- [x] theming for qt (via matugen) - ✅ Qt5/Qt6 Material Design colors implemented
- [] human clipboard

## 📁 Directory Structure

```
native_configuration/
├── README.md              # This file
├── install.sh             # Installation script
├── hyprland/
│   ├── hyprland.conf      # Shared Hyprland configuration
│   ├── colors.conf        # Material Design 3 color palette (matugen)
│   ├── aya/
│   │   └── hyprland.conf  # ThinkPad E14 AMD (HiDPI) config
│   ├── rin/
│   │   └── hyprland.conf  # Standard DPI config
│   └── utsuho/
│       └── hyprland.conf  # Main desktop PC config
├── waybar/
│   ├── config.json        # Waybar configuration
│   ├── style.css          # Waybar styling
│   └── colors.css         # Material Design 3 colors for CSS
├── rofi/
│   └── config.rasi        # Application launcher configuration
├── dunst/
│   └── dunstrc            # Notification daemon configuration
├── kitty/
│   ├── kitty.conf         # Terminal configuration
│   └── colors.conf        # Terminal color theme
├── gtk/
│   ├── colors.css         # GTK Material Design colors (3.0 & 4.0)
│   └── gtk.css            # GTK theme configuration
├── qt/
│   ├── qt5ct.conf         # Qt theme configuration (5 & 6)
│   └── colors/
│       └── matugen.conf   # Qt Material Design colors
├── fonts/                 # Input font files (bundled)
├── wallpapers/            # Desktop wallpapers
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
- **Borders**: Material Design 3 color palette with dynamic gradients
- **Opacity**: Active windows 100%, inactive 80%
- **Animations**: Smooth bezier curves

#### Material Design 3 Theming
- **Color Generation**: Uses matugen to extract colors from wallpapers
- **Dynamic Borders**: Application-specific color coding (dev tools, media, system apps)
- **Workspace Colors**: Different color themes for different workspace types
- **Status Bar**: Contextual colors for system status (battery, network, audio)
- **Consistent Palette**: Shared colors between Hyprland and Waybar

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

#### Terminal
- **Emulator**: Kitty with optimized performance
- **Font**: Input MonoNarrow (bundled) or JetBrains Mono Nerd Font
- **Theme**: Darkside (dark color scheme)
- **Features**: Tabs, scrollback, URL highlighting, mouse support

#### Notifications
- **Daemon**: Dunst with modern styling
- **Theme**: Dark with accent colors matching window borders
- **Position**: Top-right corner with rounded corners
- **Features**: Progress bars, icons, action buttons, history

#### Theming
- **GTK 3.0/4.0**: Material Design 3 colors generated from wallpaper
- **Qt5/Qt6**: Material Design 3 colors via qt5ct/qt6ct with custom palette
- **Icons**: Adwaita icon theme
- **Wayland**: Native Qt and GTK support with proper scaling
- **Consistent Colors**: All applications match Hyprland/Waybar color palette

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
qt6ct

# Terminal
kitty

# File manager
thunar

# Fonts for terminal
ttf-jetbrains-mono-nerd

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
   mkdir hyprland/newmachine
   ```

2. **Create machine-specific config**:
   ```bash
   mkdir hyprland/newmachine
   cp hyprland/aya/hyprland.conf hyprland/newmachine/hyprland.conf
   ```

3. **Edit the configuration**:
   ```bash
   # Edit monitor scaling and wallpaper
   nano hyprland/newmachine/hyprland.conf
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
- **Colors**: Material Design 3 colors automatically applied via `colors.css`

### Color Theme Customization

#### Using Matugen (Recommended)
1. **Generate new palette** from wallpaper:
   ```bash
   matugen image ~/Pictures/wallpapers/your_wallpaper.jpg --type css
   matugen image ~/Pictures/wallpapers/your_wallpaper.jpg --type hyprland
   ```

2. **Copy generated colors**:
   ```bash
   cp ~/.config/matugen/colors.css waybar/
   cp ~/.config/matugen/colors.conf hyprland/
   cp ~/.config/matugen/gtk-3.0/colors.css gtk/
   cp ~/.config/matugen/qt5ct/colors/matugen.conf qt/colors/
   ```

3. **Reload configurations**:
   ```bash
   hyprctl reload
   killall waybar && waybar &
   # GTK and Qt applications will pick up new colors on next launch
   ```

#### Manual Color Editing
- **Hyprland colors**: Edit `hyprland/colors.conf` (rgba format)
- **Waybar colors**: Edit `waybar/colors.css` (CSS format)
- **GTK colors**: Edit `gtk/colors.css` (CSS format, works for GTK 3.0 & 4.0)
- **Qt colors**: Edit `qt/colors/matugen.conf` (Qt palette format, works for Qt5 & Qt6)
- **All files** use the same Material Design 3 color names for consistency

### Lock Screen Customization

- **Background**: Change wallpaper path in `hyprlock/hyprlock.conf`
- **Colors**: Modify input field colors and effects

## 🔧 Manual Installation

If you prefer manual installation:

```bash
# Create config directories
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar

# Copy Hyprland config
cp hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
cp hyprland/colors.conf ~/.config/hypr/colors.conf

# Copy machine-specific config (replace 'utsuho' with your machine)
cp hyprland/utsuho/hyprland.conf ~/.config/hypr/host.conf

# Copy waybar config
cp waybar/config.json ~/.config/waybar/config
cp waybar/style.css ~/.config/waybar/style.css
cp waybar/colors.css ~/.config/waybar/colors.css

# Copy lock screen config
cp hyprlock/hyprlock.conf ~/.config/hypr/

# Copy kitty config
mkdir -p ~/.config/kitty
cp kitty/kitty.conf ~/.config/kitty/
cp kitty/colors.conf ~/.config/kitty/

# Copy GTK themes (works for both 3.0 and 4.0)
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0
cp gtk/* ~/.config/gtk-3.0/
cp gtk/* ~/.config/gtk-4.0/

# Copy Qt themes (works for both Qt5 and Qt6)
mkdir -p ~/.config/qt5ct
mkdir -p ~/.config/qt6ct
cp -r qt/* ~/.config/qt5ct/
cp -r qt/* ~/.config/qt6ct/

# Install fonts
mkdir -p ~/.local/share/fonts
cp fonts/* ~/.local/share/fonts/
fc-cache -f

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

5. **Terminal font issues**
   - Install JetBrains Mono Nerd Font: `sudo pacman -S ttf-jetbrains-mono-nerd`
   - Rebuild font cache: `fc-cache -f`
   - Check available fonts: `kitty +list-fonts | grep -i jetbrains`

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

