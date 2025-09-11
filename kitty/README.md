# Native Kitty Terminal Configuration

This directory contains native Kitty terminal configuration files extracted from the NixOS setup.

## 📁 Directory Structure

```
kitty/
├── README.md         # This file
├── install.sh        # Installation script
├── kitty.conf        # Main Kitty configuration
├── Darkside.conf     # Darkside color theme
└── fonts/            # Input font files (bundled)
    ├── Input_Regular_(InputMonoNarrow_Regular).ttf
    ├── Input_Bold_(InputMonoNarrow_Bold).ttf
    ├── Input_Italic_(InputMonoNarrow_Italic).ttf
    └── Input_BoldItalic_(InputMonoNarrow_BoldItalic).ttf
```

## 🚀 Quick Installation

```bash
# Install the configuration
./install.sh

# Test the configuration
kitty --config ~/.config/kitty/kitty.conf
```

## ⚙️ Configuration Details

### Main Features

- **Font**: Input MonoNarrow (size 16, bundled)
- **Theme**: Darkside (dark color scheme)
- **Shell**: Zsh integration
- **Editor**: Neovim for text editing
- **Scrollback**: 10,000 lines

### Key Features

#### Visual Settings
- **Tab bar**: Bottom position with powerline style
- **No audio bell**: Visual feedback disabled
- **URL highlighting**: Clickable links with custom styling
- **Mouse hiding**: Auto-hide after 3 seconds of inactivity

#### Performance
- **Optimized rendering**: Low repaint and input delay
- **Monitor sync**: Smooth animation support
- **Efficient scrolling**: Large scrollback buffer

#### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+W` | Close tab |
| `Ctrl+Shift+→/←` | Switch tabs |
| `Ctrl+Shift+Enter` | New window |
| `Ctrl+Shift+N` | New OS window |
| `Ctrl+Shift+Plus/Minus` | Font size adjustment |
| `Ctrl+Shift+Backspace` | Reset font size |

## 🎨 Darkside Theme

The Darkside theme provides:
- **Dark background**: Easy on the eyes
- **High contrast**: Good readability
- **Syntax highlighting**: 16-color palette optimized for code
- **Modern colors**: Purple, cyan, and green accents

### Color Palette
- **Background**: Dark gray (`#1e1e1e`)
- **Foreground**: Light gray (`#f8f8f2`)
- **Accent colors**: Purple, cyan, green, red, yellow
- **Selection**: Subtle blue highlight

## 🔧 Customization

### Changing Font Size
Edit `kitty.conf`:
```ini
font_size 14.0  # Increase from 12.0
```

### Changing Theme
Replace `Darkside.conf` with another theme or modify colors directly.

### Adding Custom Keybindings
Add to `kitty.conf`:
```ini
map ctrl+shift+f toggle_fullscreen
map ctrl+shift+u scroll_page_up
map ctrl+shift+d scroll_page_down
```

## 📦 Dependencies

### Required
- **kitty** - The terminal emulator itself

### Font Dependencies
- **JetBrainsMono Nerd Font** - For icons and proper rendering

Install on various systems:
```bash
# Arch Linux
sudo pacman -S kitty ttf-jetbrains-mono-nerd

# Ubuntu/Debian
sudo apt install kitty fonts-jetbrains-mono

# Fedora
sudo dnf install kitty jetbrains-mono-fonts
```

## 🔄 Integration with Hyprland

This configuration works seamlessly with the Hyprland setup:
- **Terminal variable**: Set as `$terminal = kitty` in Hyprland config
- **Keybinding**: `Super+Return` launches Kitty
- **Wayland native**: Optimized for Wayland/Hyprland environment

## 🛠️ Troubleshooting

### Font Not Found
If JetBrainsMono Nerd Font isn't available:
```bash
# Check available fonts
kitty +list-fonts | grep -i jetbrains

# Fallback to system monospace
# Edit kitty.conf and change font_family to 'monospace'
```

### Theme Not Loading
Ensure `Darkside.conf` is in the same directory as `kitty.conf`:
```bash
ls ~/.config/kitty/
# Should show: kitty.conf Darkside.conf
```

### Performance Issues
For slower systems, adjust in `kitty.conf`:
```ini
repaint_delay 16    # Increase from 10
input_delay 5       # Increase from 3
```

## 📋 Manual Installation

If you prefer manual installation:

```bash
# Create config directory
mkdir -p ~/.config/kitty

# Copy configuration files
cp kitty.conf ~/.config/kitty/
cp Darkside.conf ~/.config/kitty/

# Test configuration
kitty --config ~/.config/kitty/kitty.conf
```

---

*This configuration provides a modern, efficient terminal experience optimized for development workflows.*
