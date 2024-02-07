#!/usr/bin/env bash

# Adapted from: <https://github.com/LGFae/swww/blob/main/example_scripts/swww_randomize.sh>

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$(basename "$0") <dir containing images>"
	exit 1
fi

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=3

find "$1" -type f \
    | while read -r img; do
        echo "$RANDOM:$img"
    done \
    | sort -n \
    | head -n1 \
    | cut -d':' -f2- \
    | (read -r img; swww img "$img")
