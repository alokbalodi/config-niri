#!/usr/bin/env bash

set -euo pipefail

EXTRACTOR="$HOME/.config/niri/scripts/keybind/keybind-extractor.sh"

binds="$("$EXTRACTOR")"

count=$(
  printf '%s\n' "$binds" |
    grep -Ec '^[^[:space:]].*->'
)

notify-send \
  "Niri Keybinds" \
  "$count bindings loaded" \
  -t 2000

printf '%s\n' "$binds" |
  fuzzel \
    --dmenu \
    --prompt "Keybinds> "
