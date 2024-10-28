#!/bin/bash
DIR="/home/ronnas/Pictures/wallpapers/images"  # Change this to your wallpaper directory
while true; do
    PIC=file://$(ls $DIR/* | shuf -n1)  # Randomly select a jpg file
    gsettings set org.cinnamon.desktop.background picture-uri "$PIC"  # For MATE
    sleep 15  # Wait for 15 seconds
done