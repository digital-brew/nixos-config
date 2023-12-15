#!/usr/bin/env bash

# Check if Waybar is running
if pidof waybar > /dev/null
then
    kill -9 $(pidof waybar)
fi

# Check if Waybar is installed and in the PATH
if command -v waybar > /dev/null
then
    waybar --config ~/.config/eww/widgets/waybar/waybar_config --style ~/.config/eww/widgets/waybar/waybar_style.css &
else
    echo "Waybar is not installed and/or in the path."
fi