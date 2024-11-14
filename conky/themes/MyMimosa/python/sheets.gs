function fetchTodayAndTomorrowCalendarEvents() {
   const spreadsheetId = '1M8vQ_93zWw5q5lQToaguxcj17EtSoQu1FgdfjNHj_Gc'; // Replace with your actual Spreadsheet ID
  const sheetName = 'Calendar'; // Replace with your actual Sheet Name
  // Get the active sheet
    // Access the specified spreadsheet and sheet
  const spreadsheet = SpreadsheetApp.openById(spreadsheetId);
  const sheet = spreadsheet.getSheetByName(sheetName);

  // const sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  sheet.clear(); // Clear any previous content
  sheet.appendRow(["Event ID", "Event Title", "Start Time", "End Time", "Description"]); // Set headers

  // Get today's date range
  const startOfToday = new Date();
  startOfToday.setHours(0, 0, 0, 0);
  
 
  const endOfTomorrow = new Date();
  endOfTomorrow.setDate(endOfTomorrow.getDate() + 1);
  endOfTomorrow.setHours(23, 59, 59, 999);
  
  // Fetch events from the primary calendar
  const calendarId = Session.getActiveUser().getEmail(); // Use user's primary calendar
  const events = CalendarApp.getCalendarById(calendarId).getEvents(startOfToday, endOfTomorrow);
  
  // Loop through events and write them to the sheet
  events.forEach(event => {
    const eventId = event.getId();
    const eventTitle = event.getTitle();
    const startTime = event.getStartTime();
    const endTime = event.getEndTime();
    const description = event.getDescription() || "No description"; // Default if no description

    sheet.appendRow([eventId, eventTitle, startTime, endTime, description]);
  });

  Logger.log("Today's and tomorrow's calendar events have been fetched and updated in the sheet.");
}