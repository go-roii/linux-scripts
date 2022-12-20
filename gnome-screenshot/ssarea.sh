#!/bin/bash
# area screenshot
DATE=$(date "+%Y-%m-%d %H:%M:%S")
gnome-screenshot -a -f "/home/$USER/Pictures/Screenshots/Screenshot from $DATE.png"
