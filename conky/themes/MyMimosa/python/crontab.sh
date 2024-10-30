crontab -l > crontab.txt
echo "0 */1 * * *  bash /home/ronnas/.config/conky/MyMimosa/calendar.sh" >> crontab.txt
crontab crontab.txt
rm crontab.txt