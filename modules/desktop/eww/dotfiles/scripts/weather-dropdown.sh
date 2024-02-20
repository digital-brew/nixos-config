#!/usr/bin/env bash

if eww state | grep -q "weather-dropdown-opened: true"; then
    eww update weather-dropdown-opened=false
else
    eww update power-dropdown-opened=false ethernet-dropdown-opened=false keyboard-dropdown-opened=false weather-dropdown-opened=true
fi