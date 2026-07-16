#!/bin/bash
# Autotroca de wallpaper via conky (execi). Sem sleep/slideshow: intervalo controlado pelo conky.
CURBG=$(gsettings get org.cinnamon.desktop.background picture-uri)
NEXTBG="'file://$(jq -r .next ~/.config/conky/MyMimosa/.cache/stats.json)'"
if [[ $CURBG == $NEXTBG ]]; then
  IMAGE_DIR="/home/ronnas/Pictures/wallpapers/images"
  RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f | shuf -n 1)
  NEXTBG="file://$RANDOM_IMAGE"
fi
gsettings set org.gnome.desktop.background picture-uri $NEXTBG
