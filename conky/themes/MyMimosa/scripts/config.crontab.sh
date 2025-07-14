#!/bin/bash
crontab -l > input.txt
echo "*/15 * * * *  bash /home/ronnas/.config/conky/MyMimosa/calendar.sh" >> input.txt
echo "*/15 * * * *  bash /home/ronnas/.config/conky/MyMimosa/scripts/my.download.sh" >> input.txt
echo "*/30 * * * *  python3 /home/ronnas/.config/conky/MyMimosa/python/rss_parser.py" >> input.txt
sort -u input.txt > output.txt
rm input.txt
cat output.txt | crontab -
rm output.txt
