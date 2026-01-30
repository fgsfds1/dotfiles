# AGENTS.md

## Chezmoi Config Management
Source: `~/.local/share/chezmoi/chezmoi/` → Destination: `~/.config/`
Files prefixed with `dot_` are copied to their destination location.
- `.chezmoi.toml.tmpl`: Template generating `~/.config/chezmoi/chezmoi.toml` on init
- Edit source files directly, then `chezmoi apply` to sync

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
- `bootstrap.sh`: Quick setup
- `install_dependencies.sh`: Arch dependencies
- `random_wallpaper.sh`: Wallpapers
- `test-notifications.sh`: Test notifications

## Git Workflow
- `chezmoi cd` → navigate to source directory
- `git add . && git commit` → commit changes (be succinct)
- `chezmoi git push` → push to remote

## Common Operations
- `chezmoi apply --dry-run` → preview changes
- `chezmoi status` → check managed files
- `chezmoi managed` → list all managed entries
