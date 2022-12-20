#!/bin/bash
pacmd set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo

ACTIVE_PORT=$(cat .ACTIVE_PORT)

if [[ ${ACTIVE_PORT} == "LINEOUT" ]]; then
    pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones
    echo "HEADPHONES" > .ACTIVE_PORT
    notify-send --expire-time=2000 --icon=audio-card --app-name="System" "Active Port" "Headphones"
else
    pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-lineout
    echo "LINEOUT" > .ACTIVE_PORT
    notify-send --expire-time=2000 --icon=audio-card --app-name="System" "Active Port" "Lineout"
fi
