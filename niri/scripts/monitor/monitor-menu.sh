#!/usr/bin/env bash

set -euo pipefail

CHOICE=$(
  printf "%s\n" \
    "Laptop" \
    "TV" |
    fuzzel \
      --dmenu \
      --prompt "Monitor> "
)

[[ -z "$CHOICE" ]] && exit 0

case "$CHOICE" in
"Laptop")
  "$HOME/.config/niri/scripts/monitor/laptop-only.sh"
  ;;

"TV")
  "$HOME/.config/niri/scripts/monitor/tv-only.sh"
  ;;

*)
  exit 1
  ;;
esac
