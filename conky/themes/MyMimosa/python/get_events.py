from datetime import datetime, timedelta, date, timezone
import tzlocal
from decouple import config
from gcsa.google_calendar import GoogleCalendar


time_min = datetime.now()
time_max = datetime.now() + timedelta(days=2)

print("Starting get_events script")

NUMBER_EVENTS = 5

try:
    emails = config("EMAILS").split(";")
    tokens = config("TOKENS_PATH").split(";")
    print(f"Loaded {len(emails)} email accounts.")
except Exception as e:
    print(f"Error loading configuration: {e}")
    emails = []
    tokens = []

data = []

for email, token_path in zip(emails, tokens):
    try:
        calendar = GoogleCalendar(
            email,
            token_path=token_path,
        )
        print(f"Credenciais validas: {calendar.credentials.valid}")
        print(f"Fetching events for {email} from {time_min} to {time_max}")
        for event in calendar.get_events(
            time_min, time_max, order_by="startTime", single_events=True
        ):
            print(f"Fetched event: {event.summary} from {email}")
            data.append(event)
    except Exception as e:
        print(f"Error fetching events for {email}: {e}")

print(f"Fetched {len(data)} events from calendars.")

if len(data) > 1:

    def get_event_start_as_datetime(event):
        start = event.start
        if isinstance(start, datetime):
            dt = start
        elif isinstance(start, date):
            dt = datetime.combine(start, datetime.min.time())
        else:
            dt = start
        # Garantir que seja offset-aware
        if dt.tzinfo is None or dt.tzinfo.utcoffset(dt) is None:
            try:
                local_tz = tzlocal.get_localzone()
                dt = dt.replace(tzinfo=local_tz)
            except Exception:
                dt = dt.replace(tzinfo=timezone.utc)
        return dt

    data = sorted(data, key=lambda x: get_event_start_as_datetime(x))
    print(f"Processing top {min(len(data), NUMBER_EVENTS)} events.")
    counter = 0
    content = ""
    for event in data[:NUMBER_EVENTS]:
        start_dt = get_event_start_as_datetime(event)
        end = event.end
        if isinstance(end, datetime):
            end_dt = end
        elif isinstance(end, date):
            end_dt = datetime.combine(end, datetime.min.time())
        else:
            end_dt = end
        # Garantir que end_dt também seja offset-aware
        if end_dt.tzinfo is None or end_dt.tzinfo.utcoffset(end_dt) is None:
            try:
                local_tz = tzlocal.get_localzone()
                end_dt = end_dt.replace(tzinfo=local_tz)
            except Exception:
                end_dt = end_dt.replace(tzinfo=timezone.utc)
        line = f"offset|{start_dt.strftime('%d/%m %H:%M')} to {end_dt.strftime('%H:%M')} bold|{event.summary[:32].strip()}\n"
        content += line
        counter += 1

    if counter > 0:
        try:
            with open("/tmp/conky-calendar", "w", encoding="utf-8") as file:
                file.write(content)
                file.write("\n" * max(NUMBER_EVENTS - counter, 0))
            print("Successfully wrote calendar data to /tmp/conky-calendar")
        except Exception as e:
            print(f"Error writing to /tmp/conky-calendar: {e}")
    else:
        # system("rm /tmp/conky-calendar")
        try:
            with open("/tmp/conky-calendar", "w", encoding="utf-8") as file:
                file.write("\n")
                file.write("offset|No events at the moment ...")
                file.write("\n" * (NUMBER_EVENTS - 1))
            print("Successfully wrote 'no events' message to /tmp/conky-calendar")
        except Exception as e:
            print(f"Error writing to /tmp/conky-calendar: {e}")
else:
    try:
        with open("/tmp/conky-calendar", "w", encoding="utf-8") as file:
            file.write("\n")
            file.write("offset|No events at the moment ...")
            file.write("\n" * (NUMBER_EVENTS - 1))
        print("Successfully wrote 'no events' message to /tmp/conky-calendar")
    except Exception as e:
        print(f"Error writing to /tmp/conky-calendar: {e}")
