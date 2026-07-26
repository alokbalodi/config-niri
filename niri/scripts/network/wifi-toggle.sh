#!/usr/bin/env bash

set -euo pipefail

STATUS=$(nmcli radio wifi)

if [[ "$STATUS" == "enabled" ]]; then
  nmcli radio wifi off
  notify-send "Wi-Fi" "Disabled"
else
  nmcli radio wifi on
  notify-send "Wi-Fi" "Enabled"
fi
