#!/usr/bin/env bash

if eww state | grep -q "ethernet-dropdown-opened: true"; then
    eww update ethernet-dropdown-opened=false
else
    eww update power-dropdown-opened=false ethernet-dropdown-opened=true keyboard-dropdown-opened=false weather-dropdown-opened=false
fi