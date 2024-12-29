#!/bin/bash

hyprctl dispatch tagwindow HELLBOUND

ACTIVE_TITLE=$(hyprctl clients -j | jq -r ".[] | select(.focusHistoryID == 0) | .class")
TAGS=$(hyprctl clients -j | jq -r ".[] | select(.focusHistoryID == 0) | .tags")

notify-send -t 1500 "Hyprland Script: $ACTIVE_TITLE" "$TAGS"
