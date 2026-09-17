#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

while true; do
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f 2>/dev/null | shuf -n 1)
    
    if [ -n "$WALLPAPER" ]; then
        echo "Switching wallpaper to $WALLPAPER"
        awww img "$WALLPAPER"
    else
        echo "No wallpapers found in $WALLPAPER_DIR"
    fi
    
    sleep 1800
done