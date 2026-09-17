# Dotfiles

Cross-platform dotfiles managed with [chezmoi](https://www.chezmoi.io/).  
Minimal terminal setup on both Linux (Arch-based) and macOS.

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

## What's Included

- **Shell**: ZSH with OS-specific templates
- **Ghostty**: Terminal configuration
- **Neovim**: External git repo (`kickstart-modular.nvim`), refreshed daily
- **Tmux**: Session configuration

## Common Tasks

### Update Configs
```bash
chezmoi update          # Pull from git and apply
```

### Edit Configs
```bash
chezmoi edit ~/.config/ghostty/config
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

### Platform Detection
Templates use `{{ if eq .chezmoi.os "darwin" }}` for macOS-specific sections and `"linux"` for Linux.

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

## Contributing

For development guidelines, see `AGENTS.md`.

## Repository Structure

```
.
├── .chezmoi.toml.tmpl       # chezmoi self-config template
├── .chezmoiexternal.toml    # External repos (nvim)
├── .chezmoiignore           # Files never installed
├── dot_config/
│   └── ghostty/config       # Ghostty terminal
├── dot_tmux.conf            # Tmux config
├── dot_zshrc.tmpl           # Shell config with templates
├── AGENTS.md                # AI agent instructions
└── README.md                # This file
```
