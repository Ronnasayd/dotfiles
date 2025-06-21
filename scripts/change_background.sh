#!/bin/bash
# Get all PIDs matching the script name ($0)
pids=$(pgrep -f "$0")

# Loop over each PID
for pid in $pids; do
    # Skip the current script's PID
    if [ "$pid" != "$$" ]; then
        kill "$pid"
    fi
done
# Specify the directory containing your images
IMAGE_DIR="/home/ronnas/Pictures/wallpapers/images"

# Select a random image from the directory
RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f | shuf -n 1)

# Set the selected image as the desktop background
gsettings set org.gnome.desktop.background picture-uri "file://$RANDOM_IMAGE"
sleep 60
gsettings set org.cinnamon.desktop.background.slideshow slideshow-enabled true
