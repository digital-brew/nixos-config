#!/usr/bin/env bash

if eww state | grep -q "power-dropdown-opened: true"; then
    eww update power-dropdown-opened=false
else
    eww update power-dropdown-opened=true ethernet-dropdown-opened=false keyboard-dropdown-opened=false weather-dropdown-opened=false
fi