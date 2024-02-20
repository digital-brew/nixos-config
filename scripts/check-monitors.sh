#!/usr/bin/env bash

# Work setup
# DP-1 "HP Inc. HP 24w CNC03115T3 (DP-1)"
# DP-2 "HP Inc. HP 24w CNC9181MD7 (DP-2 via HDMI)"
# DP-3 "HP Inc. HP 24w CNC9502S18 (DP-3 via HDMI)"

MONITORS="`wlr-randr | grep 'HP Inc. HP 24w'`"

if [[ $MONITORS == *CNC03115T3* && $MONITORS == *CNC9181MD7* && $MONITORS == *CNC9502S18* ]]
then
    echo "Substring found"

    if [[ $1 == "sddm" ]]
    then
      echo "its sddm"
    elif [[ $1 == "hyprland" ]]
    then
      echo "its hyprland"
    else
      echo "its not sddm"
    fi
fi
