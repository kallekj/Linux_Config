#!/bin/sh

# beamer.sh

if xrandr | grep 'DP2' | grep ' connected' &>/dev/null; then
    xrandr --output DP1 --off --output DP2 --primary --mode 1280x720 --pos 0x0 --rotate normal --output eDP1 --mode 2560x1440 --pos 1280x0 --rotate normal --output HDMI1 --off
    notify-send " xrandr" "Screen layout changed: DP2 + eDP1"
    
    polybar example
    # Restarting polybar
    #/usr/local/share/doc/polybar/launch.sh
    #sleep .5
    #killall polybar
    
else
  notify-send " xrandr" "No external beamer connected"
fi

