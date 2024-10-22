#!/bin/bash
# /bin/bash -c $HOME/.config/conky/MyMimosa/scripts/my.download.sh
# /bin/bash -c $HOME/.config/conky/MyMimosa/calendar.sh
killall conky
sleep 10s
conky -c $HOME/.config/conky/MyMimosa/Mimosa.conf &> /dev/null &
# conky -c $HOME/.config/conky/MyMimosa/Mimosa.conf 
exit