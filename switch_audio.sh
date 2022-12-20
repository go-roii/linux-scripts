#!/bin/bash

# set default audio profile to stereo 
# so that the headphone port becomes available
pacmd set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo

ACTIVE_PORT_FILE='/tmp/ACTIVE_PORT'
ACTIVE_PORT=$(cat $ACTIVE_PORT_FILE)

if [[ -f "$ACTIVE_PORT_FILE" && $ACTIVE_PORT == 'HEADPHONES' ]]; then
  pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-lineout
  echo 'LINEOUT' > $ACTIVE_PORT_FILE
  notify-send --expire-time=2000 --icon=audio-card --app-name='System' 'Active Port' 'Lineout'
else
  pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones
  echo 'HEADPHONES' > $ACTIVE_PORT_FILE
  notify-send --expire-time=2000 --icon=audio-card --app-name='System' 'Active Port' 'Headphones'
fi
