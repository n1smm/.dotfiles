#!/usr/bin/env bash
# hypr_focus.sh — focus the nearest window in a given direction
# Usage: hypr_focus.sh <left|right|up|down>
dir=$1
if [[ ! $dir =~ ^(left|right|up|down)$ ]]; then
  echo "usage: $0 <left|right|up|down>" >&2
  exit 1
fi

# grab all windows as JSON
clients=$(hyprctl -j clients)

# extract the currently focused window
focused=$(jq 'map(select(.focused==true))[0]' <<<"$clients")
fx=$(jq .x <<<"$focused")
fy=$(jq .y <<<"$focused")
fw=$(jq .w <<<"$focused")
fh=$(jq .h <<<"$focused")
fid=$(jq .id <<<"$focused")

# build a jq filter to find windows strictly in that direction...
case "$dir" in
  left)   cond='(.x + .w) <= '$fx      ; sortby='- .x' ;;
  right)  cond='.x >= '$((fx+fw))       ; sortby='.x'   ;;
  up)     cond='(.y + .h) <= '$fy      ; sortby='- .y' ;;
  down)   cond='.y >= '$((fy+fh))       ; sortby='.y'   ;;
esac

# find the nearest candidate
target=$(jq -r \
  'map(select(.id != '"$fid"' and '"$cond"'))
   | sort_by('"$sortby"')
   | map(.id)[0] // empty' \
  <<<"$clients")

if [[ -n $target ]]; then
  hyprctl dispatch focuswindow address "$target"
else
  # no Hyprland window that way
  exit 2
fi

