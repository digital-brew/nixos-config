#!/usr/bin/env bash

eww open dashboard --toggle
eww update power-dropdown-opened=false
eww update power-countdown-restart-active=true
eww open power-restart --toggle
eww open left-screen-mask-power-restart --toggle
eww open right-screen-mask-power-restart --toggle

/home/moonlander/.config/eww/scripts/power-countdown.sh "restart"