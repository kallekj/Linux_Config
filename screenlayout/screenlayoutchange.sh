#!/bin/sh

# screenlayoutchange.sh

if xrandr | grep 'DP2' | grep ' connected' &>/dev/null; then
  if xrandr | grep 'HDMI1' | grep ' connected' &>/dev/null; then
    xrandr --output DP1 --off --output DP2 --off --output eDP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
    notify-send " xrandr" "Screen layout changed: HDMI1"
      
    # Restarting polybar
    sleep .5
    killall polybar
    sleep .5
    polybar example
    #sleep .5
    #killall polybar

  elif xrandr --listactivemonitors | grep -q 'eDP1'; then
    xrandr --output DP1 --off --output DP2 --primary --mode 3440x1440 --pos 0x0 --rotate normal --output eDP1 --off --output HDMI1 --off
    notify-send " xrandr" "Screen layout changed: DP2"
    
    # Restarting polybar
    sleep .5
    killall polybar
    sleep .5
    polybar example
    #sleep .5
    #killall polybar
    
  
  else
    xrandr --output DP1 --off --output DP2 --primary --mode 3440x1440 --pos 0x0 --rotate normal --output eDP1 --mode 2560x1440 --pos 3440x0 --rotate normal --output HDMI1 --off
    notify-send " xrandr" "Screen layout changed: DP2 + eDP1"

    # Restarting polybar
    sleep .5
    killall polybar
    sleep .5
    polybar example
    #sleep .5
    #killall polybar
  
  fi
else
  notify-send " xrandr" "No external displays connected"
fi

if xrandr | grep 'HDMI1' | grep ' connected' &>/dev/null; then
    xrandr --output DP1 --off --output DP2 --off --output eDP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
    notify-send " xrandr" "Screen layout changed: HDMI1"
      
    # Restarting polybar
    sleep .5
    killall polybar
    sleep .5
    polybar example
    #sleep .5
    #killall polybar
else
  notify-send " xrandr" "No external HDMI display connected"
fi