#!/bin/bash
notify-send -t 2500 "HYPRLAND" "Reloaded Hypr Config!!"
killall -SIGUSR2 waybar
hyprctl reload
waybar &
