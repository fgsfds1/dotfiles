# AGENTS.md

## Cross-Platform Architecture

Source: `~/.local/share/chezmoi/chezmoi/` → Destination: `~`

### Template System
- `.chezmoiignore.tmpl`: Platform filtering (excludes Linux/MacOS configs)
- `dot_zshrc.tmpl`: Cross-platform shell config with OS-specific paths
- Uses `{{ if eq .chezmoi.os "darwin" }}` for OS detection

### Platform-Specific Components
- **Linux**: Hyprland, Waybar, Rofi, Dunst, GTK, Qt, Matugen
- **macOS**: Native tools only (no window manager, status bar, etc.)

### Config Programs
- **hypr/**: Compositor (hyprland.conf, hyprlock.conf, hypridle.conf, colors.conf)
- **waybar/**: Status bar (config.json, style.css, colors.css)
- **rofi/**: Launcher (config.rasi)
- **kitty/**: Terminal (kitty.conf, colors.conf)
- **dunst/**: Notifications (dunstrc)
- **gtk/**: Theme (gtk.css, colors.css, settings.ini)
- **qt/**: Qt theme (qt5ct.conf, colors/)
- **matugen/**: Color generator (config.toml, generates theme colors)

## Config Programs
- **hypr/**: Compositor (hyprland.conf, hyprlock.conf, hypridle.conf, colors.conf)
- **waybar/**: Status bar (config.json, style.css, colors.css)
- **rofi/**: Launcher (config.rasi)
- **kitty/**: Terminal (kitty.conf, colors.conf)
- **dunst/**: Notifications (dunstrc)
- **gtk/**: Theme (gtk.css, colors.css, settings.ini)
- **qt/**: Qt theme (qt5ct.conf, colors/)
- **matugen/**: Color generator (config.toml, generates theme colors)

## Hook Execution
Post-apply hook reloads running programs:
- Checks pgrep for each program, reloads if active
- waybar: `killall -SIGUSR1 waybar`
- hyprland: `hyprctl reload`
- rofi: `killall rofi`
- dunst: `dunstctl reload`

## Scripts
- `bootstrap.sh`: Unified setup (auto-detects OS, uses pacman or Homebrew)
- `install_dependencies.sh`: Linux dependencies only
- `random_wallpaper.sh`: Wallpapers
- `test-notifications.sh`: Test notifications

## Git Workflow
- `chezmoi cd` → navigate to source directory
- `git add . && git commit` → commit changes (be succinct)
- `chezmoi git push` → push to remote

**Template workflow**: When adding new configs, ask "Linux, macOS, or both?" to determine if it needs `.tmpl` extension and platform filtering.

## Secrets Management
- `.chezmoi.toml.tmpl`: Defines secret prompts via `promptStringOnce`
- Secrets prompted during `chezmoi init`, stored in local config (not in git)
- Templates use `{{ .data.variablename }}` to reference secrets
- Example: sing-box uses `{{ .singbox.server }}`, `{{ .singbox.uuid }}`, etc.

## Common Operations
- `chezmoi apply --dry-run` → preview changes
- `chezmoi status` → check managed files
- `chezmoi managed` → list all managed entries
