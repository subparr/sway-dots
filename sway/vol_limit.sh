#!/bin/bash

CUR_VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n1)
[ -z "$CUR_VOL" ] && CUR_VOL=0

if [ "$1" == "up" ]; then
    NEW_VOL=$((CUR_VOL + 5))

    if [ "$NEW_VOL" -gt 100 ]; then
        NEW_VOL=100
    fi
    
elif [ "$1" == "down" ]; then
    NEW_VOL=$((CUR_VOL - 5))
    [ "$NEW_VOL" -lt 0 ] && NEW_VOL=0
else
    exit 0
fi


pactl set-sink-volume @DEFAULT_SINK@ "${NEW_VOL}%"


if [ -p /tmp/wobpipe ]; then
    echo "$NEW_VOL" > /tmp/wobpipe
fi
