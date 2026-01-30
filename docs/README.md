# Dotfiles Installation and Documentation

This directory contains detailed documentation for the dotfiles repository.

## Overview

- [INSTALL.md](INSTALL.md) - Complete installation and usage guide
- [DEPENDENCIES_ARCH.md](DEPENDENCIES_ARCH.md) - Dependency analysis and installation
- [DEPENDENCY_SCRIPTS.md](DEPENDENCY_SCRIPTS.md) - Script documentation

## Quick Links

- **Full Installation Guide**: [INSTALL.md](INSTALL.md)
- **Dependencies**: [DEPENDENCY_ARCH.md](DEPENDENCIES_ARCH.md)
- **Script Usage**: [DEPENDENCY_SCRIPTS.md](DEPENDENCY_SCRIPTS.md)

## Navigation

- **Back to Root**: `cd ..`
- **View Main README**: `cat ../README.md`

## Cheatsheet

```bash
# Install everything
chezmoi init --apply

# Update later
chezmoi update

# Install dependencies
./scripts/install_dependencies.sh

# Test notifications
./scripts/test-notifications.sh

# Random wallpaper
./scripts/random_wallpaper.sh
```

## Getting Help

1. Check [INSTALL.md](INSTALL.md) for detailed instructions
2. Review [scripts/README.md](../scripts/README.md) for script usage
3. See [chezmoi Documentation](https://www.chezmoi.io/)
