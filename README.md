# Dotfiles

Personal Hyprland setup managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

### Linux (Arch)
```bash
pacman -S chezmoi
./bootstrap.sh
```

### macOS
```bash
brew install chezmoi
./bootstrap.sh
```

## Cross-Platform Support

- Same dotfiles repo works on Linux and macOS
- Platform-specific configs are automatically excluded via `.chezmoiignore.tmpl`
- Shell configuration uses templates for OS-specific paths
- Linux gets full desktop setup (window manager, status bar, etc.)
- macOS gets minimal setup (terminal, shell, git)

## Update configs
```bash
chezmoi update
```

## Components

#### Cross-Platform
- **Shell**: .zshrc (with OS-specific templates)

#### Linux Only
- **Hyprland**: `~/.config/hypr/hyprland.conf`
- **Waybar**: `~/.config/waybar/config.json`
- **Rofi**: `~/.config/rofi/config.rasi`
- **Dunst**: `~/.config/dunst/dunstrc`
- **GTK/Qt**: `~/.config/gtk/`, `~/.config/qt5ct/`
- **Kitty**: `~/.config/kitty/kitty.conf`
- **Matugen**: `~/.config/matugen/`

#### macOS Only
- Native macOS tools (no window manager, status bar, etc.)

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

- `bootstrap.sh`: Quick setup (Linux & macOS)
- `install_dependencies.sh`: Linux dependencies only
- `random_wallpaper.sh`: Wallpapers
- `test-notifications.sh`: Test notifications

### Template System

- `.chezmoiignore.tmpl`: Platform-specific exclusions (Linux/MacOS configs)
- `dot_zshrc.tmpl`: Cross-platform shell config with OS-specific paths
- When adding new configs, ask: "Linux, macOS, or both?"

### Secrets Management

- `.chezmoi.toml.tmpl`: Prompts for secrets during `chezmoi init` (e.g., sing-box credentials)
- Secrets stored locally in `~/.config/chezmoi/chezmoi.toml` (gitignored)
- Templates reference secrets via `{{ .variablename }}`
- Safe for public repos - only prompts are committed, not actual secrets

## Assets

- **fonts/**: Input MonoNarrow terminal fonts
- **wallpapers/**: Personal wallpapers for swww

## Structure

```
chezmoi/              # chezmoi source state
├── .chezmoiignore.tmpl
├── .chezmoi.toml.tmpl
├── dot_config/       # All configs go here
│   ├── hypr/
│   ├── rofi/
│   ├── waybar/
│   ├── dunst/
│   ├── gtk/
│   ├── qt/
│   ├── kitty/
│   └── matugen/
├── images/           # Images and wallpapers
├── assets/           # Fonts (kept for now)
├── scripts/          # Utility scripts
└── docs/             # Documentation
```

## Git Workflow

```bash
# Navigate to chezmoi source
chezmoi cd

# Edit configs
nano chezmoi/dot_config/hypr/hyprland.conf

# Preview and apply
chezmoi diff
chezmoi apply

# Commit changes
git add .
git commit -m "Update config"
git push
```

## Chezmoi Commands

```bash
# Setup
chezmoi init --apply
chezmoi init --branch feature/my-config

# Track files
chezmoi add ~/.config/your-app/config
chezmoi re-add ~/.config/your-app/config  # Re-adds file if it was removed or changed

# Edit configs
chezmoi edit ~/.config/hypr/hyprland.conf  # Opens source file in editor
chezmoi edit --apply ~/.config/hypr/hyprland.conf  # Edit and apply automatically
chezmoi edit --watch ~/.config/hypr/hyprland.conf  # Auto-apply on save

# Preview changes
chezmoi diff
chezmoi diff ~/.config/hypr/hyprland.conf

# Apply changes
chezmoi apply  # Apply all pending changes
chezmoi apply --dry-run  # Show what would change without applying
chezmoi apply --force  # Apply even if manual changes exist in destination

# Update
chezmoi update  # Pull latest from repo and apply changes
chezmoi git pull && chezmoi diff  # Manual git pull then check changes

# Navigate
chezmoi cd

# Git commands
chezmoi git status
chezmoi git commit -m "Update"
chezmoi git push

# Status
chezmoi status
chezmoi managed

# Remove files
chezmoi forget ~/.config/your-app/config  # Stop managing, keep in home
chezmoi remove ~/.config/your-app/config  # Stop managing, delete from home

# Advanced
chezmoi init --one-shot  # Setup and then remove chezmoi traces (for containers)
chezmoi merge ~/.config/hypr/hyprland.conf  # Merge changes between current, source, and computed state
chezmoi re-add ~/.config/your-app/config  # Re-adds file if it was removed or changed
```

## Workflow

**Source → Destination:**
- **Source**: `~/.local/share/chezmoi/` (managed by chezmoi)
- **Destination**: `~` (your actual home directory)
- **Mapping**: `dot_*` files are copied to their destination locations

**When you edit configs:**
1. Edit files in `~/.local/share/chezmoi/`
2. Run `chezmoi diff` to preview changes
3. Run `chezmoi apply` to apply changes to `~`
4. Commit in chezmoi's git repo

**Branches:**
- Use `chezmoi init --branch` to checkout specific branch
- Use `chezmoi cd && git checkout` to switch branches
- Use `chezmoi update` to pull from current branch
