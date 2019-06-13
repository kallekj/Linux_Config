#!/bin/sh

# restore.sh

# Restores laptop display if it was disabled when an external one was connected.
# Run this with a key combination in your WM instead of tinkering with udev rules.

xrandr --output DP1 --off --output DP2 --off --output HDMI1 --off --output eDP1 --primary --mode 2560x1440 --pos 0x0 --rotate normal

# Restarting polybar
/usr/local/share/doc/polybar/launch.sh

# Sending notification
notify-send " xrandr" "Layout restored: eDP1"

# xrandr --output DP2 --primary --mode 3440x1440 --pos 0x0 --rotate normal --output
