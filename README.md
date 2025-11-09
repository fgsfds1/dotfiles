# my dotfiles

my dotfiles backup and install script

# TODO

- [X] add todo items
- [ ] fix theming (white dialog after apply)
- [ ] retheme dunst?
- [ ] fullscreen vrr @ low framerates is flickery, up min framerate?
- [ ] ru keybinds for kitty
- [ ] remove multimachine stuff?
- [ ] redo install script (install X)
- [ ] test install script in VM
- [ ] check-deps script to install script

## dirs

```
README.md              # This file
install.sh             # Installation script
hyprland/
├── hyprland.conf      # Shared Hyprland configuration
├── colors.conf        # Material Design 3 color palette (matugen)
├── aya/               # Laptop machine (not used rn)
│   └── hyprland.conf
├── rin/               # QEMU VM machine (not used, for testing)
│   └── hyprland.conf
└── utsuho/            # Main desktop PC additional config
    └── hyprland.conf
waybar/
├── config.json        # Waybar configuration
├── style.css          # Waybar styling
└── colors.css         # Material Design 3 colors for CSS
rofi/
└── config.rasi        # Application launcher configuration
dunst/
└── dunstrc            # Notification daemon configuration
kitty/
├── kitty.conf         # Terminal configuration
└── colors.conf        # Terminal color theme
hyprlock/
└── hyprlock.conf      # Screen lock configuration
gtk/
├── colors.css         # GTK Material Design colors (3.0 & 4.0)
└── gtk.css            # GTK theme configuration
qt/
├── qt5ct.conf         # Qt theme configuration (5 & 6)
└── colors/
    └── matugen.conf   # Qt Material Design colors
fonts/                 # Input font files I've generated for my personal use
wallpapers/            # Some stolen/generated wallpapers
```

## installation

```bash
# Auto-detect hostname and install
./install.sh

# Or specify machine configuration
./install.sh aya     # For ThinkPad with HiDPI
./install.sh rin     # For standard DPI setup  
./install.sh utsuho  # For main desktop PC
```

## deets

### keybinds
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

### input
- **Keyboard**: US/Russian with Caps Lock toggle

### term (kitty)
- **Font**: Input MonoNarrow (bundled)
- **Theme**: Darkside (dark color scheme)

### notifs (dunst)
- **Theme**: Dark with accent colors matching window borders
- **Position**: Top-right corner with rounded corners
- **Features**: Progress bars, icons, action buttons, history

### theming (kinda fucked)
- **GTK 3.0/4.0**: Material Design 3 colors generated from wallpaper
- **Qt5/Qt6**: Material Design 3 colors via qt5ct/qt6ct with custom palette
- **Icons**: Adwaita icon theme
- **Wayland**: Native Qt and GTK support with proper scaling
- **Consistent Colors**: All applications match Hyprland/Waybar color palette

### etc
- **Cursor size**: 64px
- **Screenshot directory**: `~/Pictures/screenshots`
- **Electron scaling**: Enabled for Wayland apps

## deps

```bash
# Core Hyprland
hyprland

# XDG Desktop Portal (required for file pickers, screen sharing, etc.)
xdg-desktop-portal
xdg-desktop-portal-hyprland

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
pwvucontrol

# Brightness control
brightnessctl

# Screenshot tool
hyprshot

# Bluetooth management (for aya)
blueman

# Additional applications
firefox
firefox-developer-edition
```

### color customization with matugen

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
