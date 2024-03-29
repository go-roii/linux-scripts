#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk, grep, lm_sensors, sed, xfce4-taskmanager

# Panel
INFO="<txt>$(sensors | awk '/Tctl/' | cut -f2 -d "+" | sed 's/\.[0-9]//g' | xargs)</txt>"
INFO+="<txtclick>psensor</txtclick>"

# Array of available logical CPUs
declare -r CPU_ARRAY=($(awk '/MHz/{print $4}' /proc/cpuinfo | cut -f1 -d "."))
# Number of logical CPU
readonly NUM_OF_CPUS="${#CPU_ARRAY[@]}"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="┌ $(grep "model name" /proc/cpuinfo | cut -f2 -d ":" | sed -n 1p | sed -e 's/^[ \t]*//')\n" # CPU vendor, model, clock
STEP=0 # to generate CPU numbers (eg. CPU0, CPU1 ...)
for CPU in "${CPU_ARRAY[@]}"; do
  STDOUT=$(( STDOUT + CPU ))
  MORE_INFO+="├─ CPU ${STEP}: ${CPU} MHz\n"
  let STEP+=1
done
MORE_INFO+="└─ Temperature: $(sensors | awk '/[Cc]ore\ 0/{print $3}')"
MORE_INFO+="</tool>"
STDOUT=$(( STDOUT / NUM_OF_CPUS )) # calculate average clock speed
STDOUT=$(awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GHz"}' <<< "${STDOUT}")

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
