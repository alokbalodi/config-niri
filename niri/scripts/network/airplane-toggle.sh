#!/usr/bin/env bash

set -euo pipefail

STATE=$(nmcli radio wifi | tr -d '[:space:]')

if [[ "$STATE" == "enabled" ]]; then
  nmcli radio all off
  notify-send "Wireless" "Disabled"
else
  nmcli radio all on
  notify-send "Wireless" "Enabled"
fi
