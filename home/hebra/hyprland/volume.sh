#!/usr/bin/env bash
set -eou pipefail

die() {
    echo "error:" "$@"
    exit 1
}

# @param: "sink" or "source"
get_mute_status() {
    pactl "get-$1-mute" "@DEFAULT_${1^^}@" |\
        perl -ne '/Mute: (yes|no)/ && print "$1"'
}

# @param: "sink" or "source"
get_volume() {
    pactl "get-$1-volume" "@DEFAULT_${1^^}@" |\
        perl -ne '/(\d+)%/ && print "$1"'
}

bar() {
    echo "$@" > "$XDG_RUNTIME_DIR/wob.sock"
}

if [[ $# -lt 2 ]]; then
    echo "volume - Volume Utility.

    Usage:
    $(basename "$0")   sink [ toggle | incr | decr ]
    $(basename "$0") source [ toggle ]"
    exit 1
fi

cmd="$1"
action="$2"

case "$cmd" in
    "sink")
        case "$action" in
            "toggle")
                pactl set-sink-mute "@DEFAULT_SINK@" toggle
                if [[ "$(get_mute_status "sink")" == "yes" ]]; then
                    bar "0"
                else
                    bar "$(get_volume "sink")"
                fi
                ;;

            "incr")
                pactl set-sink-volume "@DEFAULT_SINK@" "+10%"
                bar "$(get_volume "sink")"
                ;;

            "decr")
                pactl set-sink-volume "@DEFAULT_SINK@" "-10%"
                bar "$(get_volume "sink")"
                ;;

            *)
                die "invalid $cmd action '$action'"
                ;;
        esac
    ;;

    "source")
        case "$action" in
            "toggle")
                pactl set-source-mute "@DEFAULT_SOURCE@" toggle
                if [[ "$(get_mute_status "source")" == "yes" ]]; then
                    notify-send "Source is muted"
                else
                    notify-send "Source is active"
                fi
                ;;

            *)
                die "invalid $cmd action '$action'"
                ;;
        esac
    ;;

    *)
        die "invalid command '$cmd'"
    ;;
esac
