#!/usr/bin/env bash

set -euo pipefail

cp \
  "$HOME/.config/niri/configs/monitors-preset/laptop.kdl" \
  "$HOME/.config/niri/configs/monitors.kdl"

niri msg action load-config-file
