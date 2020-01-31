#!/bin/sh

# screenlayoutchange.sh

if xrandr | grep 'DP2' | grep ' connected' &>/dev/null; then
  # if xrandr | grep 'HDMI1' | grep ' connected' &>/dev/null; then
  #   xrandr --output DP1 --off --output DP2 --off --output eDP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
  #   notify-send " xrandr" "Screen layout changed: HDMI1"
      
  #   # Restarting polybar
  #   /usr/local/share/doc/polybar/launch.sh
  #   #sleep .5
  #   #killall polybar

  # el
  if xrandr --listactivemonitors | grep -q 'eDP1'; then
    xrandr --output DP1 --off --output DP2 --primary --mode 3440x1440 --pos 0x0 --rotate normal --output eDP1 --off --output HDMI1 --off
    notify-send " xrandr" "Screen layout changed: DP2"
    
    # Restarting polybar
    /usr/local/share/doc/polybar/launch.sh
    #sleep .5
    #killall polybar
    
  
  else
    xrandr --output DP1 --off --output DP2 --primary --mode 3440x1440 --pos 0x0 --rotate normal --output eDP1 --mode 2560x1440 --pos 3440x0 --rotate normal --output HDMI1 --off
    notify-send " xrandr" "Screen layout changed: DP2 + eDP1"

    # Restarting polybar
    /usr/local/share/doc/polybar/launch.sh
    #sleep .5
    #killall polybar
  
  fi
else
  notify-send " xrandr" "No external displays connected on thunderbolt"
fi

if xrandr | grep 'HDMI1' | grep ' connected' &>/dev/null; then
    killall polybar
    #=sleep .5
    
    #xrandr --output DP1 --off --output DP2 --off --output eDP1 --mode 2560x1440 --primary --pos 0x0 --rotate normal --output HDMI1 --mode 1920x1200 --pos 2560x0 --rotate normal
    
    xrandr --output DP1 --off --output DP2 --off --output eDP1 --off --output HDMI1 --primary --mode 1920x1200 --pos 0x0 --rotate normal
    notify-send " xrandr" "Screen layout changed: HDMI1"
    
    
    # Restarting polybar
    #/usr/local/share/doc/polybar/launch.sh
    polybar example
    #sleep .5
    #killall polybar
else
  notify-send " xrandr" "No external HDMI display connected"
fi