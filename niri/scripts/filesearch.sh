#!/usr/bin/env bash

set -euo pipefail

FILE=$(
  fd \
    --type f \
    --hidden \
    --exclude .git \
    . \
    "$HOME" |
    fzf \
      --preview "bat --color=always {}"
)

[[ -n "$FILE" ]] && setsid xdg-open "$FILE" >/dev/null 2>&1
