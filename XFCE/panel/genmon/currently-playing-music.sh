#!/usr/bin/env bash
# Dependencies: playerctl

#readonly STATUS="$(playerctl metadata --format "{{ status }}")"
readonly STATUS="$(playerctl --ignore-player=chromium metadata --format "{{ status }}" --all-players | sed -n 's/.*\(Playing\).*/\1/p')"

if [[ ${STATUS} == "Playing" ]]; then
	readonly ARTIST="$(playerctl --ignore-player=chromium metadata --format "{{ artist }}" --all-players)"
	readonly TITLE="$(playerctl --ignore-player=chromium metadata --format "{{ title }}" --all-players)"
#	readonly LENGTH=$(("${#ARTIST}" + "${#TITLE}"))
#	readonly TITLE="$(playerctl metadata --format "{{ title }}" | awk -v len=30 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }')"
	readonly ARTIST_TITLE=$(echo "${ARTIST} - ${TITLE}")
	
	readonly WINDOW_ID=$(wmctrl -l | grep "${ARTIST_TITLE}" | awk '{print $1}')

	INFO="<txt>${ARTIST} - <span weight='700'>${TITLE}</span></txt>"
	INFO+="<txtclick>xdotool windowactivate ${WINDOW_ID}</txtclick>"
	
	# tooltip
	readonly ARTIST=$(playerctl metadata --format "{{ artist }}")
	readonly ALBUM=$(playerctl metadata --format "{{ album }}")
	readonly TITLE=$(playerctl metadata --format "{{ title }}")
	
  MORE_INFO="<tool>"
  MORE_INFO+="Artist: \t${ARTIST}\n"
  MORE_INFO+="Album: \t${ALBUM}\n"
  MORE_INFO+="<span weight='Bold'>Title: \t${TITLE}</span>"
  MORE_INFO+="</tool>"
  
	echo -e "${INFO}"
fi

echo -e "${MORE_INFO}"
