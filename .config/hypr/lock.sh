#!/bin/bash
swayidle -w \
    timeout 300 'swaylock' \
    timeout 300 'hyprctl dispatch dpms off' \
    resume 'swaylock && hyprctl dispatch dpms on' \
    before-sleep 'swaylock'

