#!/usr/bin/env bash

#pactl set-sink-volume @DEFAULT_SINK@ $1%


# Function to check if the volume has changed
function has_volume_changed {
    # Logic to determine if the volume has changed goes here
    # You can use system commands or any other method to check the volume status
    # Compare the current volume with a previously stored value or obtain volume information
    # For the purpose of this example, let's assume it's stored in a variable called "previous_volume"

    # Replace the condition below with your logic to detect volume changes
    current_volume=$(eww get volume)

    if [ "$previous_volume" != "$current_volume" ]; then
        return 0  # Volume has changed
    else
        return 1  # Volume has not changed
    fi

}

# Set the initial volume value
previous_volume=$(eww get volume)

# Start a loop to monitor the volume changes
while true; do
    # Check if the volume has changed
    if has_volume_changed; then
        # Volume has changed; execute the command
        if [ "$(eww get volume-popup-active)" == "false" ]; then
          eww open volume-popup && eww update volume-popup-active=true
        fi

        # Reset the timer
        start_time=$(date +%s)
    else
        # Volume has not changed

        # Check if 3 seconds have passed and execute the command if it's stable
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))

        if [ $elapsed_time -ge 2 ]; then
            if [ "$(eww active-windows | grep "volume-popup")" != "" ]; then
                eww close volume-popup && eww update volume-popup-active=false
            fi
        fi
    fi

    # Sleep for a short duration before checking again (adjust as needed)
    sleep 0.01
    # Set the initial volume value
    previous_volume=$(eww get volume)

done