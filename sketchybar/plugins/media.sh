#!/bin/bash

# Check if Spotify is actually running first
if pgrep -x "Spotify" > /dev/null; then
    # Spotify is running, now check if it's playing
    PLAYER_STATE=$(osascript -e 'tell application "Spotify" to return player state' 2>/dev/null)

    if [ "$PLAYER_STATE" = "playing" ]; then
        MEDIA_ARTIST=$(osascript -e 'tell application "Spotify" to return artist of current track' 2>/dev/null)
        MEDIA_SONG=$(osascript -e 'tell application "Spotify" to return name of current track' 2>/dev/null)

        # Truncate long titles
        if [ ${#MEDIA_SONG} -gt 25 ]; then
            MEDIA_SONG="${MEDIA_SONG:0:22}..."
        fi

        if [ ${#MEDIA_ARTIST} -gt 20 ]; then
            MEDIA_ARTIST="${MEDIA_ARTIST:0:17}..."
        fi

        sketchybar --set media label="$MEDIA_ARTIST - $MEDIA_SONG" \
                           icon="󰝚" \
                           background.drawing=on
    elif [ "$PLAYER_STATE" = "paused" ]; then
        # Show paused state
        sketchybar --set media label="Paused" \
                           icon="󰏤" \
                           background.drawing=on
    else
        # Spotify running but not playing anything
        sketchybar --set media label="" \
                           icon="" \
                           background.drawing=off
    fi
else
    # Spotify is not running - hide the widget
    sketchybar --set media label="" \
                     icon="" \
                     background.drawing=off
fi