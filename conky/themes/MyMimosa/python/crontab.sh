crontab -l > crontab.txt
echo "*/15 * * * *  bash /home/ronnas/.config/conky/MyMimosa/calendar.sh" >> crontab.txt
crontab crontab.txt
rm crontab.txt