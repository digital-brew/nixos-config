#!/usr/bin/env bash

if eww state | grep -q "light-night-state-active: true"; then
    eww update light-night-state-active=false &&
    killall wlsunset
else
    eww update light-night-state-active=true &&
    wlsunset
fi