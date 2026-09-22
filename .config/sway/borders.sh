#!/bin/bash

stdbuf -oL swaymsg -t subscribe '["window"]' --monitor | while read -r line; do

  if [[ "$line" == *'"change": "floating"'* ]]; then

    if [[ "$line" == *'"floating": "user_on"'* ]]; then
	swaymsg border normal

    elif [[ "$line" == *'"floating": "auto_off"'* ]] || [[ "$line" == *'"floating": "none"'* ]]; then
	swaymsg border pixel

    fi

  fi
done
