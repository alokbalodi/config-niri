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
    45.90.28.29#Laptop--Alok-5927cc.dns.nextdns.io \
    45.90.30.29#Laptop--Alok-5927cc.dns.nextdns.io \
    2a07:a8c0::59:27cc#Laptop--Alok-5927cc.dns.nextdns.io \
    2a07:a8c1::59:27cc#Laptop--Alok-5927cc.dns.nextdns.io

  $SUDO resolvectl domain "$INTERFACE" "~."
  $SUDO resolvectl dnsovertls "$INTERFACE" yes

  logger "Alokkk applied on $INTERFACE"
done

# notify-send "DNS" "Alokkk active"
