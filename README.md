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
- **Neovim**: Kickstart-based config (see [Neovim](#neovim))
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

## Neovim

Kickstart-based config in `dot_config/nvim/`, plugin manager is [lazy.nvim](https://github.com/folke/lazy.nvim).

**What's where:**
- Config (managed here): `dot_config/nvim/` → `~/.config/nvim/`
- Installed plugins (NOT managed, never commit): `~/.local/share/nvim/lazy/`
- Treesitter parsers + queries (NOT managed): `~/.local/share/nvim/site/`
- `lazy-lock.json` IS managed — it pins exact plugin versions, commit it after updates

**Editing the config:** edit the source file (`chezmoi edit dot_config/nvim/init.lua`),
or edit in place in `~/.config/nvim/` and then pull the change into the source:
```bash
chezmoi re-add ~/.config/nvim/<file>
chezmoi diff && git add -A && git commit -m "..."
```

**Updating plugins:**
```bash
# inside nvim
:Lazy update            # update all plugins to latest
:Lazy                   # UI: per-plugin update/install/clean, logs, etc.

# headless from the shell
nvim --headless -c "Lazy update" -c "qa!"
```
After updating: commit `lazy-lock.json` (and any spec changes).

**Plugin doctor:**
```bash
:checkhealth lazy       # doctor for the plugin setup: broken specs, missing
                        # deps, load errors
:checkhealth            # everything (nvim-treesitter, mason, lspconfig, ...)
```
Known-benign: the `hererocks`/`luarocks` ERROR in `:checkhealth lazy` can be
ignored as long as no installed plugin requires luarocks.

**Treesitter parsers** (nvim-treesitter `main` branch, new API):
```bash
:TSUpdate               # update installed parsers to pinned versions
:TSInstall <lang>       # install a parser (+ queries)
```
Requires the `tree-sitter` CLI (pacman: `tree-sitter-cli`). Parsers live in
`~/.local/share/nvim/site/` — the config's `install()` call at startup keeps
the language list in `dot_config/nvim/lua/kickstart/plugins/treesitter.lua`
installed.

**LSP servers / tools (mason):**
```bash
:Mason                  # UI: install LSP servers, linters, formatters
```
`mason-tool-installer` auto-installs the `ensure_installed` list from
`dot_config/nvim/lua/kickstart/plugins/lspconfig.lua`.

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
├── .chezmoiignore           # Files never installed
├── dot_config/
│   ├── ghostty/config       # Ghostty terminal
│   └── nvim/                # Neovim config (kickstart-based)
├── dot_tmux.conf            # Tmux config
├── dot_zshrc.tmpl           # Shell config with templates
├── AGENTS.md                # AI agent instructions
└── README.md                # This file
```
