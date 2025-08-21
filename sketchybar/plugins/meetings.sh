#!/bin/bash

# Get upcoming meetings using AppleScript to query Calendar app
MEETING_INFO=$(osascript << 'EOF'
tell application "Calendar"
    set today to current date
    set startOfDay to today - (time of today)
    set endOfDay to startOfDay + (24 * hours)

    set upcomingEvents to {}
    repeat with cal in calendars
        set dayEvents to (every event of cal whose start date ≥ today and start date ≤ endOfDay)
        set upcomingEvents to upcomingEvents & dayEvents
    end repeat

    if length of upcomingEvents > 0 then
        set nextEvent to item 1 of upcomingEvents
        set eventStart to start date of nextEvent
        set eventSummary to summary of nextEvent

        set timeStr to time string of eventStart
        set shortTime to text 1 thru 5 of timeStr

        return shortTime & " " & eventSummary
    else
        return ""
    end if
end tell
EOF
)

if [ -n "$MEETING_INFO" ]; then
    # Truncate long meeting names
    if [ ${#MEETING_INFO} -gt 25 ]; then
        MEETING_INFO="${MEETING_INFO:0:22}..."
    fi

    sketchybar --set meetings label="$MEETING_INFO" \
                        icon="󰃭" \
                        background.drawing=on
else
    # No meetings - hide the widget completely
    sketchybar --set meetings label="" \
                        icon="" \
                        background.drawing=off
fi