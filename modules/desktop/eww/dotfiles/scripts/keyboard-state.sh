#!/usr/bin/env bash

if eww state | grep -q "keyboard-state-active: true"; then
    eww update keyboard-state-active=false
    brightnessctl -d :white:kbd_backlight set 0%
    eww update brightness=0
else
    eww update keyboard-state-active=true
    brightnessctl -d :white:kbd_backlight set 100%
    eww update brightness=100
fi