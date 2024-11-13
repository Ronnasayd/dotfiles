#!/bin/bash
icon_theme=$(gsettings get org.gnome.desktop.interface icon-theme  | tr -d "'")
folder="/usr/share/icons/$icon_theme"
trash_full="user-trash-full.svg"
trash_empty="user-trash.svg"
subfolder="places"
list=("16x16" "22x22" "24x24" "32x32" "48x48" "64x64")
mkdir -p /tmp/trash_icons_backup
mkdir -p /tmp/trash_icons
for item in "${list[@]}"; do
    mkdir -p "/tmp/trash_icons_backup/$item/$subfolder"
    mkdir -p "/tmp/trash_icons/$item/$subfolder"
    echo "$folder/$item/$trash_full"
    cp "$folder/$item/$subfolder/$trash_full" "/tmp/trash_icons_backup/$item/$subfolder"
    cp "$folder/$item/$subfolder/$trash_empty" "/tmp/trash_icons_backup/$item/$subfolder"
    convert ~/develop/personal/dotfiles/plank-links/icons/trash_empty.png -resize $item "/tmp/trash_icons/$item/$subfolder/$trash_empty.png"
    convert ~/develop/personal/dotfiles/plank-links/icons/trash_full.png -resize $item "/tmp/trash_icons/$item/$subfolder/$trash_full.png"

    mv "/tmp/trash_icons/$item/$subfolder/$trash_full.png" "/tmp/trash_icons/$item/$subfolder/$trash_full"
    mv "/tmp/trash_icons/$item/$subfolder/$trash_empty.png" "/tmp/trash_icons/$item/$subfolder/$trash_empty"

    yes | sudo cp -rf "/tmp/trash_icons/$item/$subfolder" "$folder/$item"
done