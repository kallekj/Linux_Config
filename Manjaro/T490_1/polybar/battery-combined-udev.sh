#!/bin/sh

battery_print() {
    path_ac="/sys/class/power_supply/AC"
    path_battery_0="/sys/class/power_supply/BAT0"
    path_battery_1="/sys/class/power_supply/BAT1"

    ac=0
    battery_level_0=0
    battery_level_1=0
    battery_max_0=0
    battery_max_1=0

    RED=`tput setaf 1`
    GREEN=`tput setaf 2`
    YELLOW=`tput setaf 3`
    NC=`tput sgr0`
    #RED='\033[0;31m'
    #GREEN='\033[0;32m'
    #YELLOW='\033[1;33m'
    #NC='\033[0m' # No Color


    if [ -f "$path_ac/online" ]; then
        ac=$(cat "$path_ac/online")
    fi

    if [ -f "$path_battery_0/energy_now" ]; then
        battery_level_0=$(cat "$path_battery_0/energy_now")
    fi

    if [ -f "$path_battery_0/energy_full" ]; then
        battery_max_0=$(cat "$path_battery_0/energy_full")
    fi

    if [ -f "$path_battery_1/energy_now" ]; then
        battery_level_1=$(cat "$path_battery_1/energy_now")
    fi

    if [ -f "$path_battery_1/energy_full" ]; then
        battery_max_1=$(cat "$path_battery_1/energy_full")
    fi

    battery_level=$(("$battery_level_0 + $battery_level_1"))
    battery_max=$(("$battery_max_0 + $battery_max_1"))

    battery_percent=$(("$battery_level * 100"))
    battery_percent=$(("$battery_percent / $battery_max"))

    if [ "$ac" -eq 1 ]; then
        icon=
        color=$YELLOW
        #icon="#1"

        if [ "$battery_percent" -gt 97 ]; then
            #echo "$icon"
            echo -e "${color} $icon ${NC}"
        else
            color=$GREEN
            #echo "$icon $battery_percent %"
            echo -e "${color} $icon ${NC} $battery_percent %"
        fi
    else
        if [ "$battery_percent" -gt 85 ]; then
            icon=""
            color=$GREEN
            #icon="#21"
        elif [ "$battery_percent" -gt 60 ]; then
            icon=""
            color=$GREEN
            #icon="#22"
        elif [ "$battery_percent" -gt 35 ]; then
            icon=""
            color=$YELLOW
            #icon="#23"
        elif [ "$battery_percent" -gt 10 ]; then
            icon=""
            color=$RED
            #icon="#24"
        else
            icon=""
            color=$GREEN
            #icon="#25"
        fi

        echo "${color} $icon ${NC} $battery_percent %"
        #echo "$icon $battery_percent %"
    fi
}


case "$1" in
    --update)
        pid=$(pgrep -xf "/bin/sh /home/user/.config/polybar/battery-combined-udev.sh")
        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)

    trap exit INT
        trap "echo" USR1

        while true; do
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac


#path_pid="~/.config/polybar/battery-combined-udev.pid"

#case "$1" in
#    --update)
#        pid=$(cat $path_pid)

#        if [ "$pid" != "" ]; then
#            kill -10 "$pid"
#        fi
#        ;;
#    *)
#        echo $$ > $path_pid
#
#        trap exit INT
#        trap "echo" USR1

#        while true; do
#            battery_print

#            sleep 30 &
#            wait
#        done
#        ;;
#esac
