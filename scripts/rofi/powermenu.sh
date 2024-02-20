#!/usr/bin/env bash
MACBOOK_MIC="alsa_output.pci-0000_04_00.3.multichannel-output.monitor"
USB_MIC="alsa_input.usb-DCMT_Technology_USB_Condenser_Microphone_214b206000000178-00.mono-fallback"
AUDIO_INPUT=$USB_MIC

LEFT_DISPLAY="DP-1"
CENTER_DISPLAY="DP-2"
RIGHT_DISPLAY="DP-3"

DIR="$HOME/Screenshots"
VIDEO_NAME="recording_$(date +%Y%m%d_%H%M%S).mp4"

option_1="Restart"
option_2="Power Off"
option_3="Lockscreen"
option_4="Logout"

options="$option_1\n$option_2\n$option_3\n$option_4"

choice=$(echo -e "$options" | rofi -dmenu -i -p "󰐥" -config ~/nixos-config/modules/desktop/rofi/dotfiles/conf/powermenu.rasi)

case $choice in
    $option_1)
        grim -g "$(slurp)" - | convert - -shave 1x1 PNG: - | swappy -f -
        notify-send "Screenshot created" "Mode: $msg_1"
    ;;
    $option_2)
        grim -o $LEFT_DISPLAY - | convert - -shave 1x1 PNG: - | swappy -f -
        notify-send "Screenshot created" "Mode: $msg_2"
    ;;
    $option_3)
        grim -o $CENTER_DISPLAY - | convert - -shave 1x1 PNG: - | swappy -f -
        notify-send "Screenshot created" "Mode: $msg_3"
    ;;
    $option_4)
        grim -o $RIGHT_DISPLAY - | convert - -shave 1x1 PNG: - | swappy -f -
        notify-send "Screenshot created" "Mode: $msg_4"
    ;;
    *)
        exit 1
    ;;
esac
