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

/home/ronnas/develop/personal/dotfiles/scripts/change_background_auto.sh
/home/ronnas/develop/personal/dotfiles/conky/themes/MyMimosa/python/background-blur.py
