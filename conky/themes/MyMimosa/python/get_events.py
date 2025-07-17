from datetime import datetime, timedelta
import os 
from datetime import timedelta,datetime,timezone
from decouple import config
from gcsa.google_calendar import GoogleCalendar

time_min = datetime.now()
time_max = datetime.now() + timedelta(days=2)

NUMBER_EVENTS = 5

emails = config("EMAILS").split(";")
tokens = config("TOKENS_PATH").split(";")
data = []

for email, token_path in zip(emails, tokens):
    calendar = GoogleCalendar(
        email,
        token_path=token_path,
    )
    for event in calendar.get_events(
        time_min, time_max, order_by="startTime", single_events=True
    ):
        data.append(event)

data = sorted(data, key=lambda x: x.start)

if len(data) > 1:
    counter = 0
    content = ""
    os.system("for i in `atq | awk '{print $1}'`;do atrm $i;done")
    for event in data[:NUMBER_EVENTS]:
        line = f"offset|{event.start.strftime('%d/%m %H:%M')} to {event.end.strftime('%H:%M')} {event.summary[:32]}\n"
        content += line
        counter += 1
        if datetime.now(timezone.utc) - event.start < timedelta(days=1):
            print(f"echo \"notify-send\" '{event.summary}' | at {event.start.strftime('%H:%M')}")
            os.system(f"echo \"notify-send\" '{event.summary}' | at {event.start.strftime('%H:%M')}") 
    if counter > 0:
        with open("/tmp/conky-calendar", "w", encoding="utf-8") as file:
            file.write(content)
            file.write("\n" * max(NUMBER_EVENTS - counter, 0))
    else:
        # system("rm /tmp/conky-calendar")
        with open("/tmp/conky-calendar", "w", encoding="utf-8") as file:
            file.write("\n")
            file.write("offset|No events at the moment ...")
            file.write("\n" * (NUMBER_EVENTS - 1))
else:
    with open("/tmp/conky-calendar", "w", encoding="utf-8") as file:
        file.write("\n")
        file.write("offset|No events at the moment ...")
        file.write("\n" * (NUMBER_EVENTS - 1))
