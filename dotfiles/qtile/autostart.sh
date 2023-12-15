#!/bin/sh

SCREEN_0="eDP-1"
SCREEN_1="DP-1-4"
SCREEN_2="DP-1-5"
SCREEN_3="DP-1-6"

# Set screens placement and resolution
if xrandr | grep "$SCREEN_1 connected"; then
    xrandr --output $SCREEN_0 --off --output $SCREEN_1 --mode 1920x1080 --output $SCREEN_2 --primary --mode 1920x1080 --right-of $SCREEN_1 --output $SCREEN_3 --mode 1920x1080 --right-of $SCREEN_2 &
else
    xrandr --output $SCREEN_0 --mode 1440x900 &
fi

killall picom && picom -b &

nm-applet &

# Set the mouse cursor
xsetroot -cursor_name Breeze_Snow &

#flameshot &