#!/usr/bin/env bash

if [ "$1" == "restart" ]; then
  reboot
fi

if [ "$1" == "off" ]; then
  poweroff
fi