#!/bin/bash

# Get the class of the currently focused window
focused_class=$(hyprctl clients -j | jq -r '.[] | select(.focused) | .class')

# Check if the focused window is kitty
if [[ "$focused_class" == "kitty" ]]; then
    # Do nothing if the focused window is kitty
    exit 0
else
    # Resize the whole window using hyprctl
    case "$1" in
        up) hyprctl dispatch resizeactive 0 -20 ;;
        down) hyprctl dispatch resizeactive 0 20 ;;
        left) hyprctl dispatch resizeactive -20 0 ;;
        right) hyprctl dispatch resizeactive 20 0 ;;
    esac
fi

