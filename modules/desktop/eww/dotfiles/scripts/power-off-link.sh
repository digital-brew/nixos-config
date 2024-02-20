#!/usr/bin/env bash

eww open dashboard --toggle
eww update power-dropdown-opened=false
eww update power-countdown-off-active=true
eww open power-off --toggle
eww open left-screen-mask-power-off --toggle
eww open right-screen-mask-power-off --toggle

/home/moonlander/.config/eww/scripts/power-countdown.sh "off"