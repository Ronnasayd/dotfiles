import datetime
import os.path
from pprint import pprint
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from glob import glob
from os import remove,getcwd

SCOPES = ["https://www.googleapis.com/auth/calendar.readonly"]

def main():
  basepath = os.path.dirname(os.path.abspath(__file__))
  if os.path.exists("/tmp/conky-calendar"):
    remove("/tmp/conky-calendar")
  tokens = glob(f"{basepath}/tokens/*.json")
  for token in tokens:
    print(token)
    creds = None
    if os.path.exists(token):
      creds = Credentials.from_authorized_user_file(token, SCOPES)
    if not creds or not creds.valid:
      if creds and creds.expired and creds.refresh_token:
        creds.refresh(Request())
      else:
        flow = InstalledAppFlow.from_client_secrets_file(
            "credentials.json", SCOPES
        )
        creds = flow.run_local_server(port=0)
      with open(token, "w") as token:
        token.write(creds.to_json())

    try:
      service = build("calendar", "v3", credentials=creds)

      now = datetime.datetime.utcnow()
      start_of_day = now.replace(hour=0, minute=0, second=0, microsecond=0)
      # end_of_day = now.replace(hour=23, minute=59, second=59, microsecond=999999)
      end_of_tomorrow = (now + datetime.timedelta(days=1)).replace(hour=23, minute=59, second=59, microsecond=999999)
      events_result = (
          service.events()
          .list(
              calendarId="primary",
              timeMin=now.isoformat() + "Z",
              timeMax=end_of_tomorrow.isoformat() + "Z",
              maxResults=20,
              singleEvents=True,
              orderBy="startTime",
          )
          .execute()
      )
      events = events_result.get("items", [])

      if not events:
        return

      formats = [
        '%Y-%m-%dT%H:%M:%S%z',
        '%Y-%m-%d'
      ]
      # Prints the start and name of the next 10 events
      with open('/tmp/conky-calendar','w') as file:
        for event in events:
          start = event["start"].get("dateTime", event["start"].get("date"))
          for format in formats:
            try:
              start = datetime.datetime.strptime(start,format).strftime('%d/%m %H:%M')
            except ValueError:
              continue
          line = f"offset|{start} - {event['summary']}\n"
          file.write(line)
          print(line)

    except HttpError as error:
      print(f"An error occurred: {error}")


if __name__ == "__main__":
  main()