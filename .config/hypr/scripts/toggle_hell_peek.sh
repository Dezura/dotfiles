#!/bin/bash

TARGET_TAG="HELLBOUND" 

CURRENT_WORKSPACE=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .activeWorkspace.id')

WINDOWS=$(hyprctl clients -j | jq -r ".[] | select(.tags | index(\"$TARGET_TAG\")) | .address")

if [ -z "$WINDOWS" ]; then
    notify-send -u critical -t 3000 "Hyprland Script" "No windows with the specified tag found."
    exit 1
fi


for WINDOW in $WINDOWS; do
    WINDOW_WORKSPACE=$(hyprctl clients -j | jq -r ".[] | select(.address == \"$WINDOW\") | .workspace.id")

    if [ "$WINDOW_WORKSPACE" == "$CURRENT_WORKSPACE" ]; then
        # Send it to hell
        hyprctl dispatch movetoworkspacesilent special 1, address:"$WINDOW"
        notify-send -t 1500 "Hyprland Script" "Moved browser window to hell"
    else
        # Move the window to the current workspace
        hyprctl dispatch movetoworkspacesilent "$CURRENT_WORKSPACE", address:"$WINDOW"
        notify-send -t 1500 "Hyprland Script" "Moved browser window to workspace $CURRENT_WORKSPACE"
    fi
done
