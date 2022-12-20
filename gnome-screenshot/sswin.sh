#!/bin/bash
# window screenshot
DATE=$(date "+%Y-%m-%d %H:%M:%S")
gnome-screenshot -w -f "/home/$USER/Pictures/Screenshots/Screenshot from $DATE.png"
