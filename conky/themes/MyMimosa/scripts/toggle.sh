#!/bin/bash
if pgrep -x conky >/dev/null; then
    killall conky
else
    conky -c "$HOME/.config/conky/MyMimosa/Mimosa.conf" &> /dev/null &
fi
