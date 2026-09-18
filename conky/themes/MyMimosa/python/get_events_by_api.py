"""Fetch calendar events via Google Calendar API and write them for conky."""

import datetime
from glob import glob
import logging
from os import remove
import os.path
import tempfile

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import Resource, build
from googleapiclient.errors import HttpError

SCOPES = ["https://www.googleapis.com/auth/calendar.readonly"]
CALENDAR_FILE = os.path.join(tempfile.gettempdir(), "conky-calendar")

logging.basicConfig(level=logging.INFO, format="%(message)s")
logger = logging.getLogger(__name__)


def main() -> None:
    """Fetch events for all stored tokens and write the conky output file."""
    date_formats = ["%Y-%m-%dT%H:%M:%S%z", "%Y-%m-%d"]
    basepath = os.path.dirname(os.path.abspath(__file__))
    if os.path.exists(CALENDAR_FILE):
        remove(CALENDAR_FILE)
    tokens = glob(f"{basepath}/tokens/*.json")
    events_group: list[dict[str, object]] = []
    events_group = get_events_by_tokens_files(tokens, events_group)
    generate_file(date_formats, events_group)


def generate_file(
    date_formats: list[str], events_group: list[dict[str, object]]
) -> None:
    """Write up to 5 sorted events to the conky calendar file.

    Args:
        date_formats: Candidate strptime formats for event start/end times.
        events_group: Events and holidays collected from all tokens.
    """
    if len(events_group):
        events_group = sorted(
            events_group,
            key=lambda x: x["start"].get("dateTime", x["start"].get("date")),
        )
        with open(CALENDAR_FILE, "w", encoding="utf-8") as file:
            for index, event in enumerate(events_group):
                if index > 4:
                    break
                start = event["start"].get("dateTime", event["start"].get("date"))
                end = event["end"].get("dateTime", event["end"].get("date"))
                for date_format in date_formats:
                    try:
                        start = datetime.datetime.strptime(start, date_format).strftime(
                            "%d/%m %H:%M"
                        )
                        end = datetime.datetime.strptime(end, date_format).strftime(
                            "%H:%M"
                        )
                    except ValueError:
                        continue
                line = f"offset|{start} to {end} - {event['summary']}\n"
                file.write(line)
                logger.info(line)
            if len(events_group) < 5:
                file.write("\n" * (5 - len(events_group)))


def get_events_by_tokens_files(
    tokens: list[str], events_group: list[dict[str, object]]
) -> list[dict[str, object]]:
    """Fetch events and holidays for each token file.

    Args:
        tokens: Paths to stored OAuth token JSON files.
        events_group: Events collected so far, extended in place.

    Returns:
        Combined list of events and holidays across all tokens.
    """
    for token_path in tokens:
        logger.info(token_path)
        try:
            creds = refresh(token_path)
            now = datetime.datetime.utcnow()
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
            logger.error("An error occurred: %s", error)
    return events_group


def get_events(
    now: datetime.datetime, end_of_tomorrow: datetime.datetime, service: Resource
) -> list[dict[str, object]]:
    """Fetch primary calendar events between two instants.

    Args:
        now: Start of the search window.
        end_of_tomorrow: End of the search window.
        service: Authenticated Google Calendar API client.

    Returns:
        Events in the primary calendar within the window.
    """
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


def refresh(token_path: str) -> Credentials:
    """Load and, if needed, refresh OAuth credentials from a token file.

    Args:
        token_path: Path to the stored OAuth token JSON file.

    Returns:
        Valid Google OAuth credentials.
    """
    creds = None
    if os.path.exists(token_path):
        creds = Credentials.from_authorized_user_file(token_path, SCOPES)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file("credentials.json", SCOPES)
            creds = flow.run_local_server(port=0)
        with open(token_path, "w", encoding="utf-8") as token_file:
            token_file.write(creds.to_json())
    return creds


def get_hollidays(
    service: Resource, now: datetime.datetime, end_of_tomorrow: datetime.datetime
) -> list[dict[str, object]]:
    """Fetch Brazilian holiday events between two instants.

    Args:
        service: Authenticated Google Calendar API client.
        now: Start of the search window.
        end_of_tomorrow: End of the search window.

    Returns:
        Holiday events within the window.
    """
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
