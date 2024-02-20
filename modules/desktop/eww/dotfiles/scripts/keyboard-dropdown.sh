#!/usr/bin/env bash

if eww state | grep -q "keyboard-dropdown-opened: true"; then
    eww update keyboard-dropdown-opened=false
else
    eww update power-dropdown-opened=false ethernet-dropdown-opened=false keyboard-dropdown-opened=true weather-dropdown-opened=false
fi