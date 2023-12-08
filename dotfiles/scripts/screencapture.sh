#!/usr/bin/env bash

if [ -z "$1" ]; then
  exit 1
fi

if [ "$1" == "image" ]; then
  eww open --toggle  screencapture -c ~/.config/eww/screencapture
#  sleep 2
  grim -g "$(slurp)" - | convert - -shave 1x1 PNG: - | swappy -f -
fi

if [ "$1" == "screen" ]; then
  eww open --toggle  screencapture -c ~/.config/eww/screencapture
  grim -o $2 - | convert - -shave 1x1 PNG: - | swappy -f -
fi