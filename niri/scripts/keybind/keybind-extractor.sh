#!/usr/bin/env bash

set -euo pipefail

BIND_DIR="$HOME/.config/niri/binds"

print_section() {
  local file="$1"

  local section
  section=$(basename "$file" .kdl)
  section="${section^}"

  echo
  echo " $section"
}

parse_file() {
  local file="$1"

  awk '
    BEGIN {
        label = ""
    }

    # Save the last meaningful comment.
    /^[[:space:]]*\/\/[[:space:]]*[[:alnum:]]/ {
        label = $0
        sub(/^[[:space:]]*\/\/[[:space:]]*/, "", label)
        next
    }

    # Ignore decorative section headers.
    /^[[:space:]]*\/\// {
        next
    }

    # Match the start of a KDL node.
    /^[[:space:]]*[[:graph:]][^{}]*\{/ {
        line = $0

        # Remove everything after the opening brace.
        sub(/[[:space:]]*\{.*/, "", line)

        # Trim surrounding whitespace.
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)

        # Remove trailing KDL attributes (for example: cooldown-ms=150).
        sub(/[[:space:]]+[a-zA-Z0-9_-]+=.*$/, "", line)

        # Ignore structural container nodes.
        if (line == "binds" || line == "recent-windows")
            next

        if (label != "")
            printf "%-35s -> %s\n", line, label
    }
    ' "$file"
}

main() {
  local file

  for file in "$BIND_DIR"/*.kdl; do
    print_section "$file"
    parse_file "$file"
  done
}

main
