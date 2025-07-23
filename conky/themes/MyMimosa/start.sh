#!/bin/bash
/bin/bash -c $HOME/.config/conky/MyMimosa/scripts/my.download.sh
/bin/bash -c $HOME/.config/conky/MyMimosa/calendar.sh
/bin/bash -c $HOME/.config/conky/MyMimosa/python/rss_parser.py

killall conky

sleep 10s
conky -c $HOME/.config/conky/MyMimosa/Mimosa.conf &> /dev/null &
# conky -c $HOME/.config/conky/MyMimosa/Mimosa.conf
exit
