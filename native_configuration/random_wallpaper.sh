#!/usr/bin/env bash

WALLPAPER_DIR="/home/lw/Pictures/wallpapers/"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
echo "Changing wallpaper to $WALLPAPER..."

swww img $WALLPAPER
