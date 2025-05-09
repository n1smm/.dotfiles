#!/bin/bash

# Path to the images
active_bg=#1E0C07
inactive_bg=#000000

# Command to change background
change_bg() {
  kitty @ --to=$1 set-background $2
}

# Monitor focus changes
kitty @ ls | jq -r '.[0].tabs[] | .windows[] | .id' | while read window_id; do
  kitty @ watch-event window-focus-changed | while read focus_change; do
    if [[ "$focus_change" == *"$window_id"* ]]; then
      change_bg $window_id $active_bg
    else
      change_bg $window_id $inactive_bg
    fi
  done
done

