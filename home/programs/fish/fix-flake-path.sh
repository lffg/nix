#!/usr/bin/env bash

echo_fixed_nix_flake_path() {
  local flake_path=""
  local profile_path=""
  local rest_path=""

    local IFS=:
    for entry in $PATH; do
        if [[ $entry == "/nix/store/"* ]]; then
            flake_path+="${flake_path:+:}$entry"
        elif [[ $entry == *"nix"* ]] && [[ $entry == *"profile"* ]]; then
            profile_path+="${profile_path:+:}$entry"
        else
            rest_path+="${rest_path:+:}$entry"
        fi
    done

    echo "$flake_path${flake_path:+:}$profile_path${profile_path:+:}$rest_path"
}

echo_fixed_nix_flake_path