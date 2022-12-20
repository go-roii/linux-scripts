#!/usr/bin/env bash

CPULSE=$(xfconf-query -c xfwm4 -p /general/use_compositing)
if [ "$CPULSE" = "true" ]; then
   notify-send -t 2000 'XFCE' 'Disabled XFWM Compositor' --icon=video-display;
   xfconf-query -c xfwm4 -p /general/use_compositing -s false &
else 
   notify-send -t 2000 'XFCE' 'Enabled XFWM Compositor' --icon=video-display;
   xfconf-query -c xfwm4 -p /general/use_compositing -s true &
fi
exit
