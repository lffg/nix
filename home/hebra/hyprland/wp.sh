#!/usr/bin/env bash
set -eou pipefail

bg_init() {
    swww init
}

bg_next() {
    local bg_dir="$HOME/Documents/Wallpapers"
    export SWWW_TRANSITION_FPS=60
    export SWWW_TRANSITION_STEP=3

    find "$bg_dir" -type f \
        | while read -r img; do
            echo "$RANDOM:$img"
        done \
        | sort -n \
        | head -n1 \
        | cut -d':' -f2- \
        | (read -r img; swww img "$img")
}

if [[ $# -lt 1 ]]; then
    echo "wp - Wallpaper Utility.

    Usage:
    $(basename "$0") init
    $(basename "$0") next"
    exit 1
fi

cmd="$1"

case "$cmd" in
    "init") bg_init;;
    "next") bg_next;;
    *)
        echo "error: invalid command '$cmd'"
        exit 1
esac