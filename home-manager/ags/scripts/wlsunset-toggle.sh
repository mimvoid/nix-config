#!/bin/sh

if pgrep -x "wlsunset" > /dev/null
then
  pkill wlsunset > /dev/null 2>&1
else
  wlsunset -T 5000 -t 2500 -S 7:30 -s 20:00 > /dev/null 2>&1 &
fi
