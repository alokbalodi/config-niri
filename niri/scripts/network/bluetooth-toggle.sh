#!/usr/bin/env bash

set -euo pipefail

if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
  rfkill unblock bluetooth
  notify-send "Bluetooth" "Enabled"
else
  rfkill block bluetooth
  notify-send "Bluetooth" "Disabled"
fi
