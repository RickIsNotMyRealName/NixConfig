#!/usr/bin/env bash
#!nix-shell -i bash -p grim slurp wl-clipboard imagemagick

# This script is called when a screenshot is taken.
# Steps:
# 1. Take a screenshot
# 1.1. Capture the entire screen (grim)
# 1.2. Let the user select a region (slurp)
# 1.3. Only use the selected region (imagemagick)
# 2. Save the screenshot to disk
# 3. Copy the screenshot to the clipboard
# 4. Send a notification

# Logging function
log() {
    echo "[$(date --iso-8601=seconds)] $1"
}

# Ensure that the directories for the screenshots exist
mkdir -p ~/Pictures/Screenshots

# Ensure that all the required programs are installed
if ! command -v grim &> /dev/null; then
    log "grim is not installed"
    exit 1
fi

if ! command -v slurp &> /dev/null; then
    log "slurp is not installed"
    exit 1
fi

if ! command -v wl-copy &> /dev/null; then
    log "wl-copy is not installed"
    exit 1
fi

if ! command -v convert &> /dev/null; then
    log "imagemagick is not installed"
    exit 1
fi

if ! command -v feh &> /dev/null; then
    log "feh is not installed"
    exit 1
fi

if ! command -v hyprctl &> /dev/null; then
    log "hyprctl is not installed"
    exit 1
fi



# Take a screenshot
# make a temporary file
#screenshot=$(mktemp --suffix=.png)
screenshot=~/Pictures/Screenshots/$(date --iso-8601=seconds).png
log "Taking a screenshot and saving it to $screenshot"

# capture the entire screen
grim -t png $screenshot
log "Captured the entire screen"

# let the user select a region
region=$(slurp -f "%x %y %w %h")
# ensure that the user has selected a region
if [ -z "$region" ]; then
    log "The user has not selected a region"
    exit 1
fi
log "The user has selected the region $region"



# Crop the screenshot to the selected region
width=$(echo $region | cut -d' ' -f3)
height=$(echo $region | cut -d' ' -f4)
x=$(echo $region | cut -d' ' -f1)
y=$(echo $region | cut -d' ' -f2)
convert $screenshot -crop ${width}x${height}+${x}+${y} +repage $screenshot

log "Cropped the screenshot to the selected region"

# Copy the screenshot to the clipboard
wl-copy < $screenshot
log "Copied the screenshot to the clipboard"

# Open a feh window that is floating and always on top
feh --borderless --title "PinnedScreenshot" --geometry ${width}x${height}+${x}+${y} $screenshot &
log "Opened a feh window with the screenshot"

sleep 0.1

# Use hyprctl to tile the feh window
# title is the title of the window and should be a regex expression that matches the title of the window, e.g. "Screenshot"
hyprctl dispatch pin title:"^(PinnedScreenshot)$"
