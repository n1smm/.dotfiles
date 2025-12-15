#!/usr/bin/env bash

#this script notifies if battery level is low
BATTERY_FILE="/sys/class/power_supply/BAT0/capacity"
THRESHOLD=10

FLAG="/tmp/.battery_low_warned"

while sleep 180; do
  # make sure the file exists
  [[ -f $BATTERY_FILE ]] || continue

  # read the number inside the file into $cap
  cap=$(<"$BATTERY_FILE")

  if (( cap <= THRESHOLD )); then
    # only notify once per drop
    if [[ ! -f $FLAG ]]; then
      # hyprctl syntax: icon-id timeout_ms color message
      hyprctl notify 0 10000 "rgb(ff0000)" \
        "fontsize:35 Battery critically low: ${cap}%"
      touch "$FLAG"
    fi
  else
    # once you charge above THRESHOLD, clear the flag
    [[ -f $FLAG ]] && rm -f "$FLAG"
  fi
done
