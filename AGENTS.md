# Instructions for AI Agents

This is a cross-platform dotfiles repository managed with chezmoi.
Supports Linux (Arch-based) and macOS (minimal setup).

## Repository Layout

- `.chezmoi.toml.tmpl` - chezmoi self-config template
- `.chezmoiexternal.toml` - External repos (nvim)
- `.chezmoiignore` - Files never installed
- `dot_config/` - All managed configs (dot_ prefix = . in destination)
  - `ghostty/` - Terminal config
- `dot_zshrc.tmpl` - Shell config with OS-specific sections
- `AGENTS.md` - This file (AI agent instructions)
- `README.md` - Human-readable documentation

## File Naming Conventions

- `dot_*` → becomes `.` in home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- `*.tmpl` → template file, processed with Go templates
- `.chezmoiignore` → files never installed on any OS
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
- Templates use `{{ if eq .chezmoi.os }}` for OS-specific sections
- Both platforms: Minimal (shell, terminal, tmux, nvim)

## Secrets Management

- `.chezmoi.toml.tmpl` defines prompts via `promptStringOnce`
- Secrets prompted during `chezmoi init`, stored in `~/.config/chezmoi/chezmoi.toml` (gitignored)
- Templates reference secrets via `{{ .section.key }}`
- **NEVER commit actual secrets** - only prompts go in git
- Current secrets: none

## Adding New Configs

**Before adding files, determine platform scope:**
1. Ask: "Linux, macOS, or both?"
2. Platform-specific: Use `.tmpl` extension with `{{ if eq .chezmoi.os }}` conditionals
3. Identical across platforms: Add as regular file

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
- Shell configs → source or restart shell

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
- Format: "verb + what" (e.g., "Add waybar config", "Fix zshrc template")
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
# Linux machine at 10.14.47.8 (utsuho)
ssh 10.14.47.8

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

- `.chezmoiignore` - Files never installed
- `.chezmoi.toml.tmpl` - chezmoi self-config template
- `~/.config/chezmoi/chezmoi.toml` - Rendered local config (NEVER in git)
