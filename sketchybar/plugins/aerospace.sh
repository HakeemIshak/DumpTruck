#!/bin/bash

# Get current workspace from aerospace
if command -v aerospace >/dev/null 2>&1; then
    CURRENT_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)

    # If empty, default to 1
    if [ -z "$CURRENT_WORKSPACE" ]; then
        CURRENT_WORKSPACE="1"
    fi
else
    CURRENT_WORKSPACE="1"
fi

# Function to get app icon
get_app_icon() {
    case "$1" in
        "Google Chrome"|"Chrome") echo "" ;;
        "Safari" | "Arc") echo "" ;;
        "Firefox" | "Zen") echo "󰈹" ;;
        "Spotify") echo "" ;;
        "Music") echo "󰝚" ;;
        "Code"|"Visual Studio Code") echo "󰨞" ;;
        "Xcode") echo "" ;;
        "Terminal" | "iTerm2" | "Ghostty") echo "" ;;
        "Postman") echo "" ;;
        "Finder") echo "󰀶" ;;
        "Mail") echo "󰇮" ;;
        "Messages") echo "󰍦" ;;
        "Slack") echo "󰒱" ;;
        "Discord") echo "󰙯" ;;
        "System Preferences"|"System Settings") echo "󰒓" ;;
        "Activity Monitor") echo "󰓌" ;;
        "Calculator") echo "󰃬" ;;
        "Calendar") echo "󰸗" ;;
        "Notes") echo "󱞎" ;;
        "Preview") echo "󰋲" ;;
        "TextEdit") echo "󰈮" ;;
        "Pages") echo "󰈮" ;;
        "Numbers") echo "󰧮" ;;
        "Keynote") echo "󰐨" ;;
        *) echo "󰣆" ;; # Generic app icon
    esac
}

# Update all workspace indicators
for i in {1..5}; do
    # Get apps in this workspace
    if command -v aerospace >/dev/null 2>&1; then
        APPS_IN_WORKSPACE=$(aerospace list-windows --workspace $i --format '%{app-name}' 2>/dev/null | sort | uniq)

        # Create app icon indicators with spacing
        APP_INDICATORS=" > -"
        if [ -n "$APPS_IN_WORKSPACE" ]; then
            APP_COUNT=0
            while IFS= read -r app && [ $APP_COUNT -lt 3 ]; do
                if [ -n "$app" ]; then
                    ICON=$(get_app_icon "$app")
                    # Add spaces around each icon for padding
                    if [ $APP_COUNT -eq 0 ]; then
                        APP_INDICATORS=" ${ICON}"
                    else
                        APP_INDICATORS="${APP_INDICATORS} ${ICON}"
                    fi
                    APP_COUNT=$((APP_COUNT + 1))
                fi
            done <<< "$APPS_IN_WORKSPACE"

            # Add "+" if more than 3 apps
            TOTAL_APPS=$(echo "$APPS_IN_WORKSPACE" | wc -l | tr -d ' ')
            if [ "$TOTAL_APPS" -gt 3 ]; then
                APP_INDICATORS="${APP_INDICATORS} +"
            fi

            # Add trailing space
            APP_INDICATORS=" >${APP_INDICATORS} "
        fi
    fi

    if [ "$i" = "$CURRENT_WORKSPACE" ]; then
        # Active workspace styling
        sketchybar --set workspace.$i background.color=0xff007acc \
                                     background.border_color=0xff0099ff \
                                     icon.color=0xffffffff \
                                     icon="$i" \
                                     label="$APP_INDICATORS" \
                                     label.drawing=on
    else
        # Inactive workspace styling
        sketchybar --set workspace.$i background.color=0xff3a3a3a \
                                     background.border_color=0xff555555\
                                     icon.color=0xffffffff \
                                     icon="$i" \
                                     label="$APP_INDICATORS" \
                                     label.drawing=on
    fi
done