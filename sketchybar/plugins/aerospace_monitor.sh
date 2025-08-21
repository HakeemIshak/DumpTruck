#!/bin/bash

# Optimized background monitor for aerospace workspace changes
LAST_WORKSPACE=""

while true; do
    # Only monitor when aerospace is available and has windows
    if command -v aerospace >/dev/null 2>&1; then
        WINDOW_COUNT=$(aerospace list-windows --all 2>/dev/null | wc -l)

        # Only check workspace if aerospace is managing windows
        if [ "$WINDOW_COUNT" -gt 0 ]; then
            CURRENT_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)

            if [ "$CURRENT_WORKSPACE" != "$LAST_WORKSPACE" ] && [ -n "$CURRENT_WORKSPACE" ]; then
                # Run the existing aerospace.sh script to update indicators
                ~/.config/sketchybar/plugins/aerospace.sh
                LAST_WORKSPACE="$CURRENT_WORKSPACE"
            fi
        else
            # No windows managed by aerospace, reset to workspace 1
            if [ "$LAST_WORKSPACE" != "1" ]; then
                LAST_WORKSPACE="1"
                ~/.config/sketchybar/plugins/aerospace.sh
            fi
        fi
    fi

    sleep 1
done