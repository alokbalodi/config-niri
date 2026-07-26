#!/usr/bin/env bash

set -euo pipefail

SERVICE="idle.service"
NOTIFY_ID=9001

if systemctl --user --quiet is-active "$SERVICE"; then
  systemctl --user stop "$SERVICE"
  notify-send -r "$NOTIFY_ID" "Idle Manager" "Auto-lock disabled"
else
  systemctl --user start "$SERVICE"
  notify-send -r "$NOTIFY_ID" "Idle Manager" "Auto-lock enabled (5 min)"
fi
