#!/usr/bin/env bash

# Prefer the active WireGuard interface if one exists.
VPN=$(
  nmcli -t -f NAME,TYPE connection show --active |
    awk -F: '$2=="wireguard"{print $1; exit}'
)

if [[ -n "$VPN" ]]; then
  INTERFACE="$VPN"
else
  INTERFACE=$(ip route | awk '/default/ {print $5; exit}')
fi

DNS=$(
  resolvectl status "$INTERFACE" 2>/dev/null |
    awk '/Current DNS Server:/ {print $4; exit}'
)

if [[ "$DNS" == *5927cc* ]]; then
  STATUS="NX"
elif [[ "$DNS" == *ff5ecc* ]]; then
  STATUS="WK"
elif [[ "$DNS" =~ ^(1\.1\.1\.1|1\.0\.0\.1|2606:4700) ]]; then
  STATUS="CF"
elif [[ -z "$DNS" ]]; then
  STATUS="NO"
else
  STATUS="??"
fi

if [[ -n "$VPN" ]]; then
  echo "$VPN $STATUS"
else
  if [[ "$STATUS" == "??" ]]; then
    echo "??"
  else
    echo "$STATUS DNS"
  fi
fi
