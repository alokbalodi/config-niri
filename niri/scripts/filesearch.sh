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

[[ -n "$FILE" ]] && kitty --detach -e nvim "$FILE"
