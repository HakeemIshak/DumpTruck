#!/bin/bash

# Aerospace Workspace Indicators
# Creates numbered workspace buttons with app icons and minimal spacing

##### Workspace Styling #####
workspace_style=(
  # Fonts
  icon.font="0xProto Nerd Font:Bold:16.0"
  label.font="0xProto Nerd Font:Bold:14.0"

  # Colors
  icon.color=0xffffffff
  label.color=0xffffffff

  # Layout and padding
  icon.padding_left=5
  icon.padding_right=0
  label.padding_left=0
  label.padding_right=15

  # Appearance
  background.color=0xff3a3a3a
  background.corner_radius=6
  background.height=24
  background.border_width=1
  background.border_color=0xff555555

  # Interaction
  cursor=pointer
)

##### Create Workspaces with Spacing #####
for i in {1..5}; do
  # Add workspace indicator
  sketchybar --add item workspace.$i left \
             --set workspace.$i "${workspace_style[@]}" \
                               icon="$i" \
                               label="" \
                               click_script="aerospace workspace $i" \
                               script="$PLUGIN_DIR/aerospace.sh"

  # Add spacing between workspaces (except after the last one)
  if [ $i -lt 5 ]; then
    sketchybar --add item workspace_spacer_$i left \
               --set workspace_spacer_$i width=5 \
                                        background.drawing=off \
                                        icon.drawing=off \
                                        label.drawing=off
  fi
done

##### Initialize #####
# Force initial update to show current workspace state
"$PLUGIN_DIR/aerospace.sh"