#!/usr/bin/env bash

set -euo pipefail

VPN_DIR="$HOME/.config/niri/wireguard"

CURRENT=$(
  nmcli -t -f NAME,TYPE connection show --active |
    awk -F: '$2=="wireguard"{print $1; exit}'
)

[[ -z "$CURRENT" ]] && CURRENT="OFF"

MENU=$(
  {
    echo "Current: $CURRENT"
    echo "Disconnect VPN"
    echo "──────────────"

    find "$VPN_DIR" \
      -maxdepth 1 \
      -type f \
      -name "*.conf" \
      -printf "%f\n" |
      sed 's/\.conf$//' |
      sort
  }
)

CHOICE=$(
  printf "%s\n" "$MENU" |
    fuzzel \
      --dmenu \
      --prompt "VPN> "
)

[[ -z "$CHOICE" ]] && exit 0

case "$CHOICE" in
"Current:"*)
  exit 0
  ;;

"──────────────")
  exit 0
  ;;

"Disconnect VPN")
  ACTIVE=$(
    nmcli -t -f NAME,TYPE connection show --active |
      awk -F: '$2=="wireguard"{print $1; exit}'
  )

  if [[ -z "$ACTIVE" ]]; then
    notify-send "VPN" "No VPN active"
  else
    nmcli connection down "$ACTIVE" >/dev/null

    "$HOME/.config/niri/scripts/network/dns-alokkk.sh"

    notify-send "VPN" "Disconnected: $ACTIVE"
  fi

  exit 0
  ;;

*)
  SERVER="$CHOICE"

  if [[ "$CURRENT" == "$SERVER" ]]; then
    notify-send "VPN" "Already connected to $SERVER"
    exit 0
  fi

  if [[ "$CURRENT" != "OFF" ]]; then
    nmcli connection down "$CURRENT" >/dev/null
  fi

  if ! nmcli -t -f NAME connection show | grep -Fxq "$SERVER"; then
    nmcli connection import type wireguard \
      file "$VPN_DIR/$SERVER.conf" >/dev/null

    nmcli connection modify \
      "$SERVER" \
      connection.autoconnect no
  fi

  nmcli connection up "$SERVER" >/dev/null

  sudo /etc/NetworkManager/dispatcher.d/nextdns "$SERVER" up

  notify-send "VPN" "Connected: $SERVER"

  exit 0
  ;;
esac
