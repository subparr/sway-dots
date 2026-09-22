#!/bin/bash

echo '{"version": 1,"click_events": true}'
echo '['
echo '[]'

#for cpu ticks
prev_idle=0
prev_total=0


print_n_calc_bar() {
	date_formatted=$(date "+%a %F %I:%M %p")
	cap=$(cat /sys/class/power_supply/BAT*/capacity)
	stat=$(cat /sys/class/power_supply/BAT*/status)
	cpu_stats=$(grep 'cpu ' /proc/stat)
	read -r _ user nice system idle iowait irq softirq steal _ <<< "$cpu_stats"
	curr_idle=$((idle + iowait))
	curr_total=$((user + nice + system + idle + iowait + irq + softirq + steal))
	diff_idle=$((curr_idle - prev_idle))
	diff_total=$((curr_total - prev_total))	

	if [ "$diff_total" -eq 0 ]; then
	    cpu_now="0.0"
	else
	    cpu_now=$(awk "BEGIN {printf \"%.1f\", 100 * ($diff_total - $diff_idle) / $diff_total}")
	fi

	layout=$(swaymsg -t get_inputs | grep "xkb_active_layout_name" | head -n1 | cut -c32-33)
	bat="[$cap%] $([ "$stat" = "Discharging" ] && echo "▼" || echo "▲")"
	mem=$(free -h | awk '/^Mem:/ {print $3 "/" $2}' | tr -d 'i')
	net=$(ip route show default | awk '/default/ {print $5 " Up"}')



	echo ',[
	
		{"name":"net","full_text":"'${net:-Offline}'","separator":"false"},
		{"name":"sep","full_text":"|","separator":"false"},
		{"name":"CPU","full_text":"CPU '$cpu_now'%","separator":"false"},
		{"name":"sep","full_text":"|","separator":"false"},
		{"name":"RAM","full_text":"'$mem'","separator":"false"},
		{"name":"sep","full_text":"|","separator":"false"},
		{"name":"battery","full_text":"'$bat'","separator":"false"},
		{"name":"sep","full_text":"|","separator":"false"},
		{"name":"kb_layout","full_text":"'$layout'","separator":"false"},
		{"name":"sep","full_text":"|","separator":"false"},
		{"name":"clock","full_text":"'$date_formatted'","separator":"false","align":"right"},

		
    ]'
#for cpu again
	prev_idle=$curr_idle
	prev_total=$curr_total
    
}


(while true; do
    print_n_calc_bar
    sleep 1
done) &


while read -r line; do
	[[ "$line" =~ \"x\":\ ([0-9]+),\ \"y\":\ ([0-9]+) ]] || continue
	    
	    X="${BASH_REMATCH[1]}"
	    Y="${BASH_REMATCH[2]}"
		
	    if (( X >= 1910 && Y <= 10 )); then
			if [[ "$line" == *'"button": 4'* ]]; then
		    	exec ~/.config/sway/vol_limit.sh up &
		      
			elif [[ "$line" == *"\"button\": 5"* ]]; then
		    	exec ~/.config/sway/vol_limit.sh down &

			elif [[ "$line" == *'button": 1'* ]]; then
		    	notify-send 'Menu' 'Test'
		fi
    fi
done


