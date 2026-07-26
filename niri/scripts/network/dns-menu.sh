#!/usr/bin/env bash

set -euo pipefail

CHOICE=$(
  printf "%s\n" \
    "Alokkk" \
    "Work" \
    "Cloudflare" |
    rofi \
      -dmenu \
      -i \
      -p "DNS"
)

[[ -z "$CHOICE" ]] && exit 0

case "$CHOICE" in
"Alokkk")
  bash "$HOME/.config/niri/scripts/network/dns-alokkk.sh"
  ;;

"Work")
  bash "$HOME/.config/niri/scripts/network/dns-wrk.sh"
  ;;

"Cloudflare")
  bash "$HOME/.config/niri/scripts/network/dns-cloudflare.sh"
  ;;

*)
  exit 1
  ;;
esac
