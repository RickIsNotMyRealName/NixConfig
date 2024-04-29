#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq nixFlakes

# This script is called when hyprland is reloaded.

# Send a notification
echo "Sending a notification"
notify-send "Hyprland Reload Started" "Reloading the configuration"

# Reload the status bar
echo "Reloading the status bar"
pkill waybar || true; sleep 1; nohup waybar &> /dev/null &


# Reload the notification daemon
echo "Reloading the notification daemon"
pkill swaync || true; sleep 1; nohup swaync &> /dev/null &


# Send a notification
echo "Sending a notification"
notify-send "Hyprland Reload Finished" "The configuration has been reloaded"


