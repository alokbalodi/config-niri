#!/usr/bin/env bash

set -euo pipefail

URL="https://link-ip.nextdns.io/5927cc/f0acc0415c6d2b7f"

if ! command -v curl >/dev/null 2>&1; then
  notify-send "NextDNS" "curl not installed"
  exit 1
fi

if curl -fsS --max-time 10 "$URL" >/dev/null; then
  notify-send "Alokkk" "IP updated successfully"
else
  notify-send "Alokkk" "Failed to update IP"
fi
