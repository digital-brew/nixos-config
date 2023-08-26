#!/bin/sh

# Available options: 
# eDP-1, DP-1, DP-2, DP-3, DP-4, DVI-I-1-1, DVI-I-2-2
SCREEN_0="eDP-1"
SCREEN_1="DP-2"
SCREEN_2="DVI-I-1-1"
SCREEN_3="DVI-I-2-2"

# Set screens placement and resolution
if xrandr | grep "$SCREEN_1 connected"; then
    xrandr --output $SCREEN_0 --off --output $SCREEN_1 --mode 1920x1080 --output $SCREEN_2 --primary --mode 1920x1080 --left-of $SCREEN_1 --output $SCREEN_3 --mode 1920x1080 --right-of $SCREEN_1 &
else
    xrandr --output $SCREEN_0 --mode 1440x900 &
fi

killall picom && picom -b &

nm-applet &

# Set the mouse cursor
xsetroot -cursor_name Breeze_Snow &

#flameshot &