#!/usr/bin/env bash

#-- CONFIGURATION
transparent_alpha=0
maximized_alpha=100
interval=0.5
#--

alpha_prop_list=()
for prop in $(xfconf-query -c xfce4-panel -p /panels -l); do
	[[ "$prop" == *"background-alpha"* ]] && alpha_prop_list+=($prop)
done

on_maximized() {
	for alpha_prop in "${alpha_prop_list[@]}"; do
		xfconf-query -c xfce4-panel -p "$alpha_prop" -s "$maximized_alpha"
	done
}

on_no_window_maximized() {
	for alpha_prop in "${alpha_prop_list[@]}"; do
		xfconf-query -c xfce4-panel -p "$alpha_prop" -s "$transparent_alpha"
	done
}

echo $alpha_prop_list

while true; do
	current_desktop=$(wmctrl -d | grep '*' | cut -d ' ' -f1)
	is_any_window_maximized=false
	for i in $(wmctrl -lG | awk -v d="$current_desktop" '$2==d {print $1}'); do
		status=$(xprop -id $i _NET_WM_STATE)
		if [[ "$status" == *"MAXIMIZED"* && "$status" != *"HIDDEN"* ]]; then
			is_any_window_maximized=true
			break
		else
			is_any_window_maximized=false
		fi
	done
		
	if [[ $is_any_window_maximized == true ]]; then
		on_maximized
	else
		on_no_window_maximized
	fi
	
	sleep $interval
done
