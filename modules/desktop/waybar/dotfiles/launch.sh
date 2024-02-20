#!/usr/bin/env bash

#  ____  _             _    __        __          _
# / ___|| |_ __ _ _ __| |_  \ \      / /_ _ _   _| |__   __ _ _ __
# \___ \| __/ _` | '__| __|  \ \ /\ / / _` | | | | '_ \ / _` | '__|
#  ___) | || (_| | |  | |_    \ V  V / (_| | |_| | |_) | (_| | |
# |____/ \__\__,_|_|   \__|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|
#                                           |___/



# -----------------------------------------------------
# Quit running waybar instances
# -----------------------------------------------------
killall .waybar-wrapped &

sleep 2s

# -----------------------------------------------------
# Loading the configuration based on the username
# -----------------------------------------------------
if [[ $USER = "moonlander" ]]
then
    waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &
#    hyprland-autoname-workspaces -c ~/.config/workstyle/config.toml &
else
    waybar &
fi
