#!/usr/bin/env bash

set -euo pipefail

cliphist wipe

rm -f "$HOME/.cache/cliphist/db"

pkill wl-paste

wl-paste --watch cliphist store &
