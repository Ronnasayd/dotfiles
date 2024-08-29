#!/bin/bash
/bin/bash -c $HOME/.config/conky/MyMimosa/scripts/my.download.sh
/bin/bash -c $HOME/.config/conky/MyMimosa/calendar.sh
# This command will close all active conky
killall conky
sleep 10s
# Only the config listed below will be avtivated
# if you want to combine with another theme, write the command here
conky -c $HOME/.config/conky/MyMimosa/Mimosa.conf &> /dev/null &
# conky -c $HOME/.config/conky/MyMimosa/Mimosa.conf 
exit