#!/bin/bash
killall conky
source $HOME/.config/conky/MyMimosa/python/venv/bin/activate
conky -c $HOME/.config/conky/MyMimosa/Mimosa.conf
exit
