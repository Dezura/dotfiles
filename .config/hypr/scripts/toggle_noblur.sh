#!/bin/bash

# Get the ID of the currently focused window
WINDOW=$(hyprctl activewindow -j | jq -r '.address')

# Check if the window has the NOBLUR tag
if hyprctl clients -j | jq -e ".[] | select(.address == \"$WINDOW\") | .tags | contains([\"NOBLUR\"])"; then
    # Remove the NOBLUR tag
    hyprctl dispatch toggletag NOBLUR
else
    # Add the NOBLUR tag
    hyprctl dispatch tagwindow NOBLUR
fi
