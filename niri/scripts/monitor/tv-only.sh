#!/usr/bin/env bash

set -euo pipefail

cp \
  "$HOME/.config/niri/configs/monitors-preset/tv.kdl" \
  "$HOME/.config/niri/configs/monitors.kdl"

pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo

niri msg action load-config-file
