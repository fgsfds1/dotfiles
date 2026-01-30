# Assets

Additional files used by the dotfiles configuration.

## Fonts

Personal font files for terminal customization.

### Input MonoNarrow

Font family used in Kitty terminal and other applications:

- **Input Regular** - InputMonoNarrow Regular
- **Input Italic** - InputMonoNarrow Italic
- **Input Bold** - InputMonoNarrow Bold
- **Input Bold Italic** - InputMonoNarrow Bold Italic

**Installation:**
```bash
# Copy fonts to system
mkdir -p ~/.local/share/fonts
cp assets/fonts/*.ttf ~/.local/share/fonts/
fc-cache -f

# Or use chezmoi
chezmoi apply dot_kitty
```

## Wallpapers

Wallpaper images for automatic selection and display.

### Available Wallpapers

- `wp_aya.jpg` - Aya wallpaper
- `wp_rin.jpg` - Rin wallpaper
- `wp_utsuho.png` - Utsuho wallpaper

**Usage:**
```bash
# Set random wallpaper
./scripts/random_wallpaper.sh

# Or manually with swww
swww img ~/Pictures/wallpapers/wp_aya.jpg
```

## Asset Management

These files are managed separately from dotfiles since they're not configuration files:

- Font files: Installed to `~/.local/share/fonts/`
- Wallpapers: Installed to `~/Pictures/wallpapers/`

**Chezmoi Setup:**
```bash
# Apply assets
chezmoi apply

# Or apply specific directories
chezmoi apply assets/fonts
chezmoi apply assets/wallpapers
```

## Adding New Assets

### New Fonts

1. Add font file to `assets/fonts/`
2. Update font configuration in dotfiles
3. Run `chezmoi add assets/fonts/`

### New Wallpapers

1. Add image to `assets/wallpapers/`
2. Update `random_wallpaper.sh` if needed
3. Run `chezmoi add assets/wallpapers/`

## Notes

- Font files should be public domain or properly licensed
- Wallpapers should be your own or properly licensed
- Consider using chezmoi's encryption for proprietary assets
