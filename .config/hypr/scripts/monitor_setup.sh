#!/bin/bash

# Function to check and set monitor configuration
check_monitors() {
    if hyprctl monitors | grep -q "HDMI-A-1"; then
        # Disable eDP-1 if HDMI-A-1 is connected
        hyprctl keyword monitor eDP-1, disable
    else
        # Enable eDP-1 if HDMI-A-1 is not connected
        hyprctl keyword monitor eDP-1, preferred, auto, 1
    fi
}

# Initial check
check_monitors

# Monitor for changes in connected monitors
while true; do
    # Wait for a monitor connection/disconnection event
    udevadm monitor --subsystem-match=drm | while read -r; do
        # Re-check and set monitor configuration
        check_monitors
    done
done
