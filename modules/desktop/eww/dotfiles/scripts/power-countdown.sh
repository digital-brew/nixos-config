#!/usr/bin/env bash

count=60

eww update power-countdown=60

while [ $count -gt 0 ]; do
    echo $count
    sleep 1
    ((count--))
    eww update power-countdown=$count

    # Check if interrupted flag is true
    state=$(eww get power-countdown-$1-active)
    if [ "$state" == false ]; then
        exit 0
    fi
done

if [ "$1" == "restart" ]; then
  reboot
fi

if [ "$1" == "off" ]; then
  poweroff
fi