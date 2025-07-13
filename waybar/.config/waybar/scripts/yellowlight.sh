#!/usr/bin/env bash

STATE_FILE=~/.config/waybar/nightlight_state
TEMP_FILE=~/.config/waybar/nightlight_temp

# Initialize with default values
[ ! -f "$TEMP_FILE" ] && echo 6000 > "$TEMP_FILE"
[ ! -f "$STATE_FILE" ] && echo "off" > "$STATE_FILE"

current_temp=$(cat "$TEMP_FILE")
state=$(cat "$STATE_FILE")

case $1 in
    toggle)
        if [ "$state" = "off" ]; then
            hyprctl hyprsunset temperature "$current_temp"
            echo "on" > "$STATE_FILE"
            state="on"
        else
            hyprctl hyprsunset identity
            echo "off" > "$STATE_FILE"
            state="off"
        fi
        ;;
    up)
        new_temp=$((current_temp + 500))  # Larger step for wider range
        if [ $new_temp -gt 20000 ]; then  # 20000 is the maximum temperature
            new_temp=20000
        fi
        echo "$new_temp" > "$TEMP_FILE"
        current_temp=$new_temp
        [ "$state" = "on" ] && hyprctl hyprsunset temperature "$current_temp"
        ;;
    down)
        new_temp=$((current_temp - 500))  # Larger step for wider range
        if [ $new_temp -lt 1000 ]; then   # 1000 is the minimum temperature
            new_temp=1000
        fi
        echo "$new_temp" > "$TEMP_FILE"
        current_temp=$new_temp
        [ "$state" = "on" ] && hyprctl hyprsunset temperature "$current_temp"
        ;;
esac


# Output for Waybar
if [ "$state" = "on" ]; then 
    echo " $current_temp"K
else
    echo " Off"
fi
