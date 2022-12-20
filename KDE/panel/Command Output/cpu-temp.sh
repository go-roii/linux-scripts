#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk, grep, lm-sensors, sed

# Panel
INFO="$(sensors | awk '/Core /' | cut -f2 -d "+" | cut -f1 -d "(" | sed 's/\.0//g' | xargs)"

# Array of available logical CPUs
declare -r CPU_ARRAY=($(awk '/MHz/{print $4}' /proc/cpuinfo | cut -f1 -d "."))
# Number of logical CPU
readonly NUM_OF_CPUS="${#CPU_ARRAY[@]}"

STDOUT=$(( STDOUT / NUM_OF_CPUS )) # calculate average clock speed
STDOUT=$(awk '{$1 = $1 / 1024; printf "%.2f%s", $1, " GHz"}' <<< "${STDOUT}")

# Panel Print
echo "CPU: ${INFO}"
