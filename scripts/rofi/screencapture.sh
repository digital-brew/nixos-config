#!/usr/bin/env bash
MACBOOK_MIC="alsa_output.pci-0000_04_00.3.multichannel-output.monitor"
USB_MIC="alsa_input.usb-DCMT_Technology_USB_Condenser_Microphone_214b206000000178-00.mono-fallback"
AUDIO_INPUT=$USB_MIC

LEFT_DISPLAY="DP-1"
CENTER_DISPLAY="DP-2"
RIGHT_DISPLAY="DP-3"

DIR="$HOME/Screenshots"
VIDEO_NAME="recording_$(date +%Y%m%d_%H%M%S).mp4"

msg_1="Image (Selection)"
msg_2="Image (Left Screen)"
msg_3="Image (Center Screen)"
msg_4="Image (Right Screen)"
msg_5="Video (Selection)"
msg_6="Video (Left Screen)"
msg_7="Video (Center Screen)"
msg_8="Video (Right Screen)"
msg_9="Video + Audio (Selection)"
msg_10="Video + Audio (Left Screen)"
msg_11="Video + Audio (Center Screen)"
msg_12="Video + Audio (Right Screen)"

option_1="  1 - $msg_1"
option_2="  2 - $msg_2"
option_3="  3 - $msg_3"
option_4="  4 - $msg_4"
option_5="  5 - $msg_5"
option_6="  6 - $msg_6"
option_7="  7 - $msg_7"
option_8="  8 - $msg_8"
option_9="  9 - $msg_9"
option_10="10 - $msg_10"
option_11="11 - $msg_11"
option_12="12 - $msg_12"

options="$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7\n$option_8\n$option_9\n$option_10\n$option_11\n$option_12"

choice=$(echo -e "$options" | rofi -dmenu -i -p "󰋲" -config ~/nixos-config/modules/desktop/rofi/dotfiles/conf/simplified.rasi)

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
    $option_5)
        wf-recorder -g "$(slurp)" -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_5"
    ;;
    $option_6)
        wf-recorder -o $LEFT_DISPLAY -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_6"
    ;;
    $option_7)
        wf-recorder -o $CENTER_DISPLAY -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_7"
    ;;
    $option_8)
        wf-recorder -o $RIGHT_DISPLAY -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_8"
    ;;
    $option_9)
        wf-recorder -g "$(slurp)" -a $AUDIO_INPUT -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_9"
    ;;
    $option_10)
        wf-recorder -o $LEFT_DISPLAY --audio=$AUDIO_INPUT -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_10"
    ;;
    $option_11)
        wf-recorder -o $CENTER_DISPLAY --audio=$AUDIO_INPUT -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_11"
    ;;
    $option_12)
        sleep 1
        wf-recorder -o $RIGHT_DISPLAY --audio=$AUDIO_INPUT -f "$DIR/$VIDEO_NAME"
        notify-send "Screenshot created" "Mode: $msg_12"
    ;;
    *)
        exit 1
    ;;
esac
