#!/usr/bin/env bash

WALLPAPER_DIR="/home/lw/Pictures/wallpapers/"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
echo "Changing wallpaper to $WALLPAPER..."

# swww img $WALLPAPER

# Use matugen to install the wallpaper and generate the colors
matugen image $WALLPAPER

# Write the wallpaper file to the config
# change the line `swww img <some_image>` to `swww img $WALLPAPER`
sed -i "s|swww img .*\..*$|swww img $WALLPAPER|" ~/.config/hypr/host.conf
