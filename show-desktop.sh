#!/bin/sh
if xprop -root  _NET_SHOWING_DESKTOP|egrep '= 1' ; then
  wmctrl -k off ;
else
  wmctrl -k on ;
fi
