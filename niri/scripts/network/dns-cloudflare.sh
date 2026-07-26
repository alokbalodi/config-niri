#!/usr/bin/env bash

set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  SUDO=""
else
  SUDO="sudo"
fi

# Physical default-route interfaces.
DEFAULT_IFACES=$(
  ip route |
    awk '/default/ {print $5}' |
    sort -u
)

# Active WireGuard interfaces.
WG_IFACES=$(
  nmcli -t -f NAME,TYPE connection show --active |
    awk -F: '$2=="wireguard"{print $1}'
)

# Merge and deduplicate all target interfaces.
INTERFACES=$(
  printf "%s\n%s\n" "$DEFAULT_IFACES" "$WG_IFACES" |
    sed '/^$/d' |
    sort -u
)

for INTERFACE in $INTERFACES; do
  $SUDO resolvectl revert "$INTERFACE"

  $SUDO resolvectl dns "$INTERFACE" \
    1.1.1.1#one.one.one.one \
    1.0.0.1#one.one.one.one \
    2606:4700:4700::1111#one.one.one.one \
    2606:4700:4700::1001#one.one.one.one

  $SUDO resolvectl domain "$INTERFACE" "~."
  $SUDO resolvectl dnsovertls "$INTERFACE" yes

  logger "Cloudflare DNS applied on $INTERFACE"
done

notify-send "DNS" "Cloudflare active"
