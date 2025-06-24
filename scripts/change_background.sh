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

# RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f | shuf -n 1)
# gsettings set org.gnome.desktop.background picture-uri "file://$RANDOM_IMAGE"
gsettings set org.gnome.desktop.background picture-uri "file://$(jq -r .next ~/.config/conky/MyMimosa/.cache/stats.json)"
sleep 60
gsettings set org.cinnamon.desktop.background.slideshow slideshow-enabled true
