#!/usr/bin/env bash

if [ "$1" == "restart" ]; then
  eww open power-restart --toggle &&
  eww open left-screen-mask-power-restart --toggle &&
  eww open right-screen-mask-power-restart --toggle &&
  eww update power-countdown-restart-active=false
fi

if [ "$1" == "off" ]; then
  eww open power-off --toggle &&
  eww open left-screen-mask-power-off --toggle &&
  eww open right-screen-mask-power-off --toggle &&
  eww update power-countdown-off-active=false
fi