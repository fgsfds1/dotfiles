# Instructions for AI Agents

This is a cross-platform dotfiles repository managed with chezmoi.
Supports Linux (Arch-based, Hyprland desktop) and macOS (minimal setup).

## Repository Layout

- `.chezmoi.toml.tmpl` - Config template that prompts for secrets on init
- `.chezmoiignore.tmpl` - Platform filtering (excludes OS-specific configs)
- `dot_config/` - All managed configs (dot_ prefix = . in destination)
  - `hypr/` - Hyprland compositor (Linux only)
  - `waybar/` - Status bar (Linux only)
  - `rofi/`, `dunst/`, `gtk/`, `qt/`, `kitty/`, `matugen/` - Desktop components (Linux only)
  - `sing-box*.json*` - VPN config (cross-platform, uses secrets)
- `dot_zshrc.tmpl` - Shell config with OS-specific sections
- `scripts/` - Utility scripts (bootstrap, wallpapers, etc.)
- `AGENTS.md` - This file (AI agent instructions)
- `README.md` - Human-readable documentation

## File Naming Conventions

- `dot_*` → becomes `.` in home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- `*.tmpl` → template file, processed with Go templates
- `.chezmoiignore.tmpl` → controls which files are installed per OS
- Platform detection: `{{ if eq .chezmoi.os "darwin" }}` for macOS, `"linux"` for Linux

## Branches

- `master` - main branch, stable configs
- Feature branches for new configs or major changes
- Use `chezmoi init --branch <name>` to test branches on remote machines

## Cross-Platform Architecture

**Source → Destination:**
- Source: `~/.local/share/chezmoi/` (git repo, templates)
- Destination: `~` (actual dotfiles after rendering)

**Platform-specific behavior:**
- `.chezmoiignore.tmpl` excludes Linux desktop configs on macOS
- Templates use `{{ if eq .chezmoi.os }}` for OS-specific sections
- Linux: Full desktop environment (Hyprland, Waybar, etc.)
- macOS: Minimal (shell, terminal, no WM/status bar)

## Secrets Management

- `.chezmoi.toml.tmpl` defines prompts via `promptStringOnce`
- Secrets prompted during `chezmoi init`, stored in `~/.config/chezmoi/chezmoi.toml` (gitignored)
- Templates reference secrets: `{{ .singbox.server }}`, `{{ .singbox.uuid }}`, etc.
- **NEVER commit actual secrets** - only prompts go in git
- Current secrets: sing-box (server, uuid, public_key, short_id)

## Adding New Configs

**Before adding files, determine platform scope:**
1. Ask: "Linux, macOS, or both?"
2. Linux-only: Add to `.chezmoiignore.tmpl` with `{{ if eq .chezmoi.os "darwin" }}`
3. Cross-platform with differences: Use `.tmpl` extension with conditionals
4. Identical across platforms: Add as regular file

**Add files:**
```bash
chezmoi cd
# For templates:
chezmoi add --template ~/.config/app/config
# For regular files:
chezmoi add ~/.config/app/config
```

**File becomes:**
- Template: `dot_config/app/config.tmpl`
- Regular: `dot_config/app/config`

## Testing Workflow

**Before applying changes:**
```bash
chezmoi diff                    # Preview all changes
chezmoi diff ~/.config/app/config  # Preview specific file
chezmoi apply --dry-run --verbose  # Detailed preview
```

**Apply changes:**
```bash
chezmoi apply                   # Apply all
chezmoi apply ~/.config/app/config  # Apply specific file
```

**After applying, check affected programs:**
- Hyprland configs → reload with `hyprctl reload` (auto via hook)
- Waybar configs → `killall -SIGUSR1 waybar` (auto via hook)
- Shell configs → source or restart shell
- Sing-box → restart sing-box service if running

## Post-Apply Hooks

`.chezmoi.toml.tmpl` defines auto-reload for running programs:
- Detects if waybar, Hyprland, rofi, dunst are running
- Sends appropriate reload signals automatically
- **Be aware:** `chezmoi apply` may reload running programs

## Git Workflow

**Making changes:**
```bash
chezmoi cd                      # Navigate to source
# Edit files
chezmoi diff                    # Preview
chezmoi apply                   # Test locally
git status                      # Check changes
git add <files>
git commit -m "Short message"   # Be succinct
# DON'T push unless asked
```

**Commit message style:**
- Keep it short and succinct (one line preferred)
- Format: "verb + what" (e.g., "Add sing-box config", "Fix waybar colors")
- NO marketing language ("COOL FEATURES", "BLAZING FAST", etc.)
- NO excessive documentation in commit messages

## Updating Secrets

When secrets change:
```bash
# Re-run init to be prompted again
chezmoi init

# Or manually edit local config
chezmoi edit-config
```

## Testing on Remote Machine

```bash
# Linux machine at 192.168.123.100
ssh 192.168.123.100

# Test a branch
chezmoi init --branch <branch-name>
chezmoi diff
chezmoi apply
```

## Constraints

**DO:**
- Ask before running `chezmoi apply` (programs may reload)
- Test with `chezmoi diff` first
- Keep commit messages short
- Ask "Linux, macOS, or both?" when adding configs
- Verify secrets aren't hardcoded in templates

**DON'T:**
- Push to remote unless explicitly asked
- Commit actual secrets (only prompts/templates)
- Use marketing language in commits
- Add excessive documentation
- Run `chezmoi apply` without previewing first
- Assume OS - check with user for new configs

## Common Operations

```bash
# Status
chezmoi status                  # Check managed files
chezmoi managed                 # List all managed files
chezmoi data                    # View template variables

# Branch operations
chezmoi init --branch <name>    # Switch branch + re-init

# Managing files
chezmoi add --template ~/.config/app/config
chezmoi forget ~/.config/app/config   # Stop managing
chezmoi re-add ~/.config/app/config   # Re-add if changed

# Viewing rendered output
chezmoi cat ~/.config/app/config      # See final output
chezmoi execute-template < file.tmpl  # Test template
```

## Special Files Reference

- `.chezmoiignore.tmpl` - Controls which files install per OS
- `.chezmoi.toml.tmpl` - Prompts for secrets, generates local config
- `~/.config/chezmoi/chezmoi.toml` - Local config (NEVER in git)
- Post-apply hook - Auto-reloads programs after apply
