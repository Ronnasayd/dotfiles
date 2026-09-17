#!/bin/bash
# Create a Cinnamon custom keyboard shortcut.
# Usage: create-shortcut.sh <name> <command> <binding>
# Example: create-shortcut.sh "Toggle Conky" "bash /home/ronnas/.config/conky/MyMimosa/scripts/toggle.sh" "<Super>c"

set -e

NAME="$1"
COMMAND="$2"
BINDING="$3"

if [[ -z "$NAME" || -z "$COMMAND" || -z "$BINDING" ]]; then
    echo "Usage: $0 <name> <command> <binding>" >&2
    echo 'Example: $0 "Toggle Conky" "bash ~/.config/conky/MyMimosa/scripts/toggle.sh" "<Super>c"' >&2
    exit 1
fi

BASE="org.cinnamon.desktop.keybindings"
LIST_PATH="/org/cinnamon/desktop/keybindings/custom-keybindings/"

mapfile -t CURRENT < <(gsettings get "$BASE" custom-list | tr -d "[]'," )

NEXT_INDEX=0
while [[ " ${CURRENT[*]} " == *" custom${NEXT_INDEX} "* ]]; do
    NEXT_INDEX=$((NEXT_INDEX + 1))
done
SLOT="custom${NEXT_INDEX}"

NEW_LIST=$(printf "'%s', " "${CURRENT[@]}" "$SLOT")
NEW_LIST="[${NEW_LIST%, }]"
gsettings set "$BASE" custom-list "$NEW_LIST"

KEY_PATH="${BASE}.custom-keybinding:${LIST_PATH}${SLOT}/"
gsettings set "$KEY_PATH" name "$NAME"
gsettings set "$KEY_PATH" command "$COMMAND"
gsettings set "$KEY_PATH" binding "['$BINDING']"

echo "Created shortcut '$NAME' at slot $SLOT bound to $BINDING"
