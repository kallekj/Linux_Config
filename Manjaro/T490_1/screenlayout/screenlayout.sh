#!/bin/sh

sleep .1
if xrandr | grep 'DP2' | grep ' connected' &>/dev/null; then
  echo 'DP2 connected, restoring layout'
  xrandr --output DP1 --off --output DP2 --primary --mode 3440x1440 --pos 0x0 --rotate normal --output eDP1 --off --output HDMI1 --off
  echo 'Done'
else
  echo 'No DP2 detected, reverting to laptop display'
  xrandr --output DP1 --off --output HDMI1 --off --output eDP1 --primary --mode 2560x1440 --pos 0x0 --rotate normal
  echo 'Done'
fi
