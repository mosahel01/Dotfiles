#!/usr/bin/env bash

STATE_FILE=~/.config/waybar/nightlight_state
TEMP_FILE=~/.config/waybar/nightlight_temp

# Initialize files if they don't exist
[ ! -f "$TEMP_FILE" ] && echo 4000 > "$TEMP_FILE"
[ ! -f "$STATE_FILE" ] && echo "off" > "$STATE_FILE"

current_temp=$(cat "$TEMP_FILE")
state=$(cat "$STATE_FILE")

case $1 in
    toggle)
        if [ "$state" = "off" ]; then
            hyprsunset -t "$current_temp"
            echo "on" > "$STATE_FILE"
        else
            hyprctl keyword decoration:screen_shader ""
            echo "off" > "$STATE_FILE"
        fi
        ;;
    up)
        new_temp=$((current_temp + 100))
        [ $new_temp -gt 10000 ] && new_temp=10000
        echo "$new_temp" > "$TEMP_FILE"
        [ "$state" = "on" ] && hyprsunset -t "$new_temp"
        ;;
    down)
        new_temp=$((current_temp - 100))
        [ $new_temp -lt 1000 ] && new_temp=1000
        echo "$new_temp" > "$TEMP_FILE"
        [ "$state" = "on" ] && hyprsunset -t "$new_temp"
        ;;
esac


# Output for Waybar
if [ "$state" = "on" ]; then 
    echo " $current_temp"K
else
    echo " Off"
fi

# Output for Waybar
if [ "$state" = "on" ]; then 
    echo " $current_temp"K
elif [ "$state" = "off" ]; then
	echo " Off"
else 
	echo " Unknown"
fi	