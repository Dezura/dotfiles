#!/bin/bash
exit 0

TARGET_TAG="HELLBOUND" 

WINDOWS=$(hyprctl clients -j | jq -r ".[] | select(.tags | index(\"$TARGET_TAG\")) | .address")
num=0

for WINDOW in $WINDOWS; do
    num=$((num+1))
    hyprctl dispatch tagwindow -HELLBOUND [address:$WINDOW]
done

notify-send "Hyprland Script" "Emptied all windows from hell ($num)"
