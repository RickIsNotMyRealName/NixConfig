#!/usr/bin/env nix-shell
#!nix-shell -i bash -p

# Script to change wallpaper to a random one from the wallpapers directory.
# This script should handle everything related to changing the wallpaper.

# Pick a random wallpaper out of '.config/wallpapers' symlink it to '.config/wallpapers/current_wallpaper.png'
echo "Picking a random wallpaper"
wallpaper_path=~/.config/wallpapers/current_wallpaper.png
wallpaper_dir=~/.config/wallpapers

if [ -f $wallpaper_path ]; then
    rm $wallpaper_path
fi

wallpaper=$(ls $wallpaper_dir | shuf -n 1)
ln -s $wallpaper_dir/$wallpaper $wallpaper_path

# Reload the wallpaper 
echo "Reloading the wallpaper"
pkill swaybg
swaybg -i $wallpaper_path

wal -c 
wal -i ~/.config/wallpapers/current_wallpaper.png


# Send a notification
echo "Sending a notification"
notify-send "Wallpaper changed" "The wallpaper has been changed to $wallpaper"


