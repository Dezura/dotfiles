#!/bin/bash
# Kill and restart waybar whenever its config files change

CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css $HOME/.config/waybar/modules.json"

trap "killall waybar" EXIT
notify-send "Starting waybar launch script"

while true; do
	logger -i "$0: Starting waybar in background..."
	waybar &
	logger -i "$0: Started waybar PID=$!. Waiting for modifications to ${CONFIG_FILES}..."
	inotifywait -e modify ${CONFIG_FILES} 2>&1 | logger -i
	logger -i "$0 inotifywait returned $?. Killing all waybar processes..."
	killall waybar 2>&1 | logger -i
	logger -i "$0: killall waybar returned $?, wait a sec..."
	sleep 1
done
