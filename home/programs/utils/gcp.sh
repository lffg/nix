#!/usr/bin/env bash

gcp-c() {
    local CONFIG="${1:-default}"
    gcloud config configurations activate "$CONFIG"
}

main() {
    local SUB_COMMAND=$1
    local ARGS=("${@:2}")

    case "$SUB_COMMAND" in
        c) gcp-c "${ARGS[@]}" ;;
        *) >&2 echo "error: $SUB_COMMAND: invalid sub command" ;;
    esac
}

main "$@"
