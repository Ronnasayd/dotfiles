import datetime
import os.path
from glob import glob
from os import getcwd, remove
from pprint import pprint

from decouple import config
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

SCOPES = ["https://www.googleapis.com/auth/calendar.readonly"]


def main():
    formats = ["%Y-%m-%dT%H:%M:%S%z", "%Y-%m-%d"]
    basepath = os.path.dirname(os.path.abspath(__file__))
    if os.path.exists("/tmp/conky-calendar"):
        remove("/tmp/conky-calendar")
    tokens = glob(f"{basepath}/tokens/*.json")
    events_group = []
    events_group = get_events_by_tokens_files(tokens, events_group)
    generate_file(formats, events_group)


def generate_file(formats, events_group):
    if len(events_group):
        events_group = sorted(
            events_group,
            key=lambda x: x["start"].get("dateTime", x["start"].get("date")),
        )
        with open("/tmp/conky-calendar", "w") as file:
            for index, event in enumerate(events_group):
                if index > 4:
                    break
                start = event["start"].get("dateTime", event["start"].get("date"))
                end = event["end"].get("dateTime", event["end"].get("date"))
                for format in formats:
                    try:
                        start = datetime.datetime.strptime(start, format).strftime(
                            "%d/%m %H:%M"
                        )
                        end = datetime.datetime.strptime(end, format).strftime("%H:%M")
                    except ValueError:
                        continue
                line = f"offset|{start} to {end} - {event['summary']}\n"
                file.write(line)
                print(line)
            if len(events_group) < 5:
                file.write("\n" * (5 - len(events_group)))


def get_events_by_tokens_files(tokens, events_group):
    for token in tokens:
        print(token)
        try:
            creds = refresh(token)
            now = datetime.datetime.utcnow()
            # start_of_day = now.replace(hour=0, minute=0, second=0, microsecond=0)
            # end_of_day = now.replace(hour=23, minute=59, second=59, microsecond=999999)
            end_of_tomorrow = (now + datetime.timedelta(days=1)).replace(
                hour=23, minute=59, second=59, microsecond=999999
            )
            service = build("calendar", "v3", credentials=creds)
            events = get_events(now, end_of_tomorrow, service)

            if not events:
                continue

            events_group = [*events_group, *events]

            events = get_hollidays(service, now, end_of_tomorrow)

            if not events:
                continue

            events_group = [*events_group, *events]

        except HttpError as error:
            print(f"An error occurred: {error}")
    return events_group


def get_events(now, end_of_tomorrow, service):
    events_result = (
        service.events()
        .list(
            calendarId="primary",
            timeMin=now.isoformat() + "Z",
            timeMax=end_of_tomorrow.isoformat() + "Z",
            maxResults=10,
            singleEvents=True,
            orderBy="startTime",
        )
        .execute()
    )

    events = events_result.get("items", [])
    return events


def refresh(token):
    creds = None
    if os.path.exists(token):
        creds = Credentials.from_authorized_user_file(token, SCOPES)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file("credentials.json", SCOPES)
            creds = flow.run_local_server(port=0)
        with open(token, "w") as token:
            token.write(creds.to_json())
    return creds


def get_hollidays(service, now, end_of_tomorrow):
    events_result = (
        service.events()
        .list(
            calendarId="pt.brazilian#holiday@group.v.calendar.google.com",
            timeMin=now.isoformat() + "Z",
            timeMax=end_of_tomorrow.isoformat() + "Z",
            maxResults=10,
            singleEvents=True,
            orderBy="startTime",
        )
        .execute()
    )
    events = events_result.get("items", [])
    return events


if __name__ == "__main__":
    main()
