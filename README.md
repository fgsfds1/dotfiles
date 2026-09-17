# Dotfiles

Cross-platform dotfiles managed with [chezmoi](https://www.chezmoi.io/).  
Linux (Arch-based) gets full Hyprland desktop, macOS gets minimal terminal setup.

## Quick Start

### Linux (Arch)
```bash
pacman -S chezmoi
chezmoi init https://github.com/YOUR_USERNAME/dotfiles.git
chezmoi diff
chezmoi apply
```

### macOS
```bash
brew install chezmoi
chezmoi init https://github.com/YOUR_USERNAME/dotfiles.git
chezmoi diff
chezmoi apply
```

During `chezmoi init`, you'll be prompted for secrets (if any).

## What's Included

### Cross-Platform
- **Shell**: ZSH with OS-specific templates

### Linux Only
- **GTK/Qt**: Themed applications

### macOS Only
- Minimal terminal setup (no window manager or status bar)

## Common Tasks

### Update Configs
```bash
chezmoi update          # Pull from git and apply
```

### Edit Configs
```bash
chezmoi edit ~/.config/hypr/hyprland.conf
chezmoi diff            # Preview changes
chezmoi apply           # Apply changes
```

### Add New Config
```bash
chezmoi add ~/.config/app/config
# Or with templating:
chezmoi add --template ~/.config/app/config
```

### Test a Branch
```bash
chezmoi init --branch feature-name
chezmoi diff
chezmoi apply
```

## How It Works

### Architecture
- **Source**: `~/.local/share/chezmoi/` (git repository with templates)
- **Destination**: `~` (your actual home directory)
- Templates are rendered with platform-specific values during `chezmoi apply`

### File Naming
- `dot_config/` → `~/.config/`
- `*.tmpl` files are processed as Go templates
- `.chezmoiignore.tmpl` controls which files install on which OS

### Secrets Management
- Secrets are prompted during `chezmoi init`
- Stored locally in `~/.config/chezmoi/chezmoi.toml` (gitignored)
- Templates reference secrets like `{{ .mysecret.value }}`
- Only prompts are committed to git, never actual secrets

### Platform Detection
Templates use `{{ if eq .chezmoi.os "darwin" }}` for macOS-specific sections and `"linux"` for Linux.

## Configuration Details

See individual README files in each config directory:
- `dot_config/hypr/README.md` - Hyprland compositor
- `dot_config/waybar/README.md` - Status bar
- `dot_config/rofi/README.md` - Launcher
- `dot_config/dunst/README.md` - Notifications
- `dot_config/kitty/README.md` - Terminal
- `dot_config/matugen/README.md` - Color scheme generator
- `dot_config/gtk/README.md` - GTK theme
- `dot_config/qt/README.md` - Qt theme

## Scripts

- `bootstrap.sh` - Initial setup (auto-detects OS)
- `test-notifications.sh` - Test notification system

## Chezmoi Commands Reference

```bash
# Status
chezmoi status          # Show changes
chezmoi managed         # List managed files
chezmoi diff            # Preview changes

# Apply
chezmoi apply           # Apply all changes
chezmoi apply --dry-run # Preview without applying

# Edit
chezmoi edit <file>     # Edit source file
chezmoi cd              # Navigate to source directory

# Git operations
chezmoi git status
chezmoi git commit -m "message"
chezmoi git push

# Branch management
chezmoi init --branch <name>

# Remove files
chezmoi forget <file>   # Stop managing
chezmoi remove <file>   # Stop managing and delete
```

## Post-Apply Hooks

When you run `chezmoi apply`, the following programs are automatically reloaded if running:
- Hyprland → `hyprctl reload`
- Waybar → `killall -SIGUSR1 waybar`
- Rofi → `killall rofi`
- Dunst → `dunstctl reload`

## Contributing

For development guidelines, see `AGENTS.md`.

## Repository Structure

```
.
├── .chezmoi.toml.tmpl       # Prompts for secrets on init
├── .chezmoiignore.tmpl      # Platform-specific file filtering
├── dot_config/              # All configuration files
│   ├── gtk/                 # GTK theme (Linux)
│   └── qt/                  # Qt theme (Linux)
├── dot_zshrc.tmpl           # Shell config with templates
├── scripts/                 # Utility scripts
├── images/                  # Wallpapers
├── assets/                  # Fonts
├── AGENTS.md                # AI agent instructions
└── README.md                # This file
```
