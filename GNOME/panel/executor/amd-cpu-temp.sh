#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk, grep, lm_sensors, sed, xfce4-taskmanager

# Panel
INFO="$(sensors | awk '/Tctl/' | cut -f2 -d "+" | sed 's/\.[0-9]//g' | xargs)"

# Panel Print
echo -e "   ${INFO}   "
