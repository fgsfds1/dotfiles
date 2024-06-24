#!/usr/bin/env bash

swww init &
swww img ~/Pictures/wp_aya.jpg

nm-applet --indicator &
blueman-applet &

waybar &

dunst
