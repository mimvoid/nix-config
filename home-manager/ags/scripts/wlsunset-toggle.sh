#!/bin/sh

if pgrep -x "wlsunset" > /dev/null
then
  systemctl --user stop wlsunset.service > /dev/null 2>&1
else
  systemctl --user start wlsunset.service > /dev/null 2>&1 &
fi
