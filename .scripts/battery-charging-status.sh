#!/usr/bin/env bash

# this script notifies if the state of battery changes.
# so if it went from charging to discharging
# and vice versa
BATTERY_CHARGING="/sys/class/power_supply/ACAD/online"
BATTERY_CAPACITY="/sys/class/power_supply/BAT0/capacity"

battery_state=$(<"$BATTERY_CHARGING")
while sleep 2; do
	[[ -f $BATTERY_CHARGING ]] || continue

	curr_battery_state=$(<"$BATTERY_CHARGING")
	curr_capacity=$(<"$BATTERY_CAPACITY")

	if (( curr_battery_state != battery_state )); then
		if (( curr_battery_state )); then
			hyprctl notify 0 10000 "rgb(ff0000)" \
				"fontsize:35 battery is charging; currently at: ${curr_capacity}%"
		else
			hyprctl notify 0 10000 "rgb(ff0000)" \
				"fontsize:35 battery is depleting; currently at: ${curr_capacity}%"
		fi
		battery_state=$curr_battery_state
	fi
done



