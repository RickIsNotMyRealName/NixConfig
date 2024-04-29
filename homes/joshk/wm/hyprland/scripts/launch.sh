#!/usr/bin/env nix-shell
#!nix-shell -i bash -p

# This script is called when hyprland is launched.

# Change the wallpaper
~/.config/hypr/scripts/changeWallpaper.sh

hyprctl output create headless