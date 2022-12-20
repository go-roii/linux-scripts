#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk, grep, lm-sensors, sed,

# AMD Only

# Panel
INFO="$(sensors amdgpu-* | awk '/edge/' | cut -f2 -d "+" | cut -f1 -d "(" | sed 's/\.0//g' | xargs)"

if [ -z "$INFO" ]
then
    INFO="none"
fi

# Panel Print
echo "GPU: ${INFO}"

