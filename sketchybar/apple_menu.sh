#!/bin/bash

# Apple Menu Configuration
# Creates an Apple logo with dropdown menu containing system actions

##### Apple Logo Button #####
apple_logo=(
  # Icon and appearance
  icon=""
  icon.color=0xffffffff
  icon.padding_left=8
  icon.padding_right=8

  # Hide label, show background
  label.drawing=off
  background.color=0xff2a2a2a
  background.corner_radius=6
  background.height=24
  background.border_width=1
  background.border_color=0xff444444
  background.padding_left=4
  background.padding_right=4

  # Interaction
  cursor=pointer
  click_script="sketchybar --set apple_logo popup.drawing=toggle"
)

##### Menu Items Shared Styling #####
menu_item_base=(
  # Colors
  icon.color=0xffffffff
  label.color=0xffffffff

  # Layout
  icon.padding_left=8
  icon.padding_right=4
  label.padding_left=0
  label.padding_right=8

  # Appearance
  background.color=0xff2a2a2a
  background.corner_radius=4
  width=160
  cursor=pointer
)

##### Individual Menu Items #####
menu_about=(
  "${menu_item_base[@]}"
  icon="󰍉"
  label="About This Mac"
  click_script="open /System/Library/CoreServices/Applications/About\\ This\\ Mac.app; sketchybar --set apple_logo popup.drawing=off"
)

menu_restart=(
  "${menu_item_base[@]}"
  icon="󰜉"
  label="Restart"
  click_script="osascript -e 'tell app \"System Events\" to restart'; sketchybar --set apple_logo popup.drawing=off"
)

menu_shutdown=(
  "${menu_item_base[@]}"
  icon="⏻"
  label="Shutdown"
  click_script="osascript -e 'tell app \"System Events\" to shut down'; sketchybar --set apple_logo popup.drawing=off"
)

##### Popup Styling #####
popup_style=(
  popup.background.color=0xff1e1e1e
  popup.background.corner_radius=8
  popup.background.border_width=1
  popup.background.border_color=0xff444444
  popup.align=left
  popup.width=160
)

##### Create Apple Menu #####
sketchybar --add item apple_logo left \
           --set apple_logo "${apple_logo[@]}" \
                            "${popup_style[@]}" \
           \
           --add item apple_logo.about popup.apple_logo \
           --set apple_logo.about "${menu_about[@]}" \
           \
           --add item apple_logo.restart popup.apple_logo \
           --set apple_logo.restart "${menu_restart[@]}" \
           \
           --add item apple_logo.shutdown popup.apple_logo \
           --set apple_logo.shutdown "${menu_shutdown[@]}"