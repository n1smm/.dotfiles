#!/usr/bin/env sh

#non-animated bg = save; animated bg = norm; variant-animated bg = variant
type_of_bg=$1

#extracted name of selected/focused monitor
focused_name=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')


#images or videos for bg
save_bg="$HOME/Pictures/animated_wallpapers/empty_bed.png"
norm_bg="$HOME/Pictures/animated_wallpapers/ellie3.webp"
norm_variant="$HOME/Pictures/animated_wallpapers/store_%05d.webp"

if [ "$type_of_bg" = "save" ]; then
	swww img $save_bg --outputs $focused_name
	echo "changing bg to <$type_of_bg> on monitor $focused_name"
elif [ "$type_of_bg" = "norm" ]; then
	swww img $norm_bg --outputs $focused_name
	echo "changing bg to <$type_of_bg> on monitor $focused_name"
elif [ "$type_of_bg" = "variant" ]; then
	swww img $norm_variant --outputs $focused_name
	echo "changing bg to <$type_of_bg> on monitor $focused_name"
else
	echo "type \"save\", \"norm\", or \"variant\" as argument"
fi

echo $monitor_data | jq -r '.[] | select(.focused == true) | .name'


