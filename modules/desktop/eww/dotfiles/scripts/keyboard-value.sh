#!/usr/bin/env bash
value=$(brightnessctl -d :white:kbd_backlight | grep 'Current brightness:' | sed 's/.*(\([0-9]\+\)%).*/\1/')
if [[ $value == 0 ]]; then
    eww update keyboard-state-active=false
else
    eww update keyboard-state-active=true
fi

echo "$value"