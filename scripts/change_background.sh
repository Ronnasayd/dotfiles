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

# gsettings set org.gnome.desktop.background picture-uri "file://$RANDOM_IMAGE"
# RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f | shuf -n 1)
CURBG=$(gsettings get org.cinnamon.desktop.background picture-uri)
NEXTBG="'file://$(jq -r .next ~/.config/conky/MyMimosa/.cache/stats.json)'"
if [[ $CURBG == $NEXTBG ]]; then
  RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f | shuf -n 1)
  NEXTBG="file://$RANDOM_IMAGE"
fi
gsettings set org.gnome.desktop.background picture-uri $NEXTBG
sleep 60
gsettings set org.cinnamon.desktop.background.slideshow slideshow-enabled true
