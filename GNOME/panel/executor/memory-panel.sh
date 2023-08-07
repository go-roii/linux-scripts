#!/usr/bin/env bash
# Dependencies: bash>=3.2, coreutils, file, gawk

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Calculate RAM values
readonly TOTAL=$(free -b | awk '/^[Mm]em/{$2 = $2 / 1073741824; printf "%.2f", $2}')
readonly USED=$(free -b | awk '/^[Mm]em/{$3 = $3 / 1073741824; printf "%.2f", $3}')
readonly FREE=$(free -b | awk '/^[Mm]em/{$4 = $4 / 1073741824; printf "%.2f", $4}')

# Panel
INFO+="${USED}"
INFO+=" / "
INFO+="${TOTAL} GB"


# Panel Print
echo -e "<span font_family='CozetteVector' size='9pt' line_height='2'> ${INFO} </span><executor.markup.true>"
