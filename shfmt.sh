#!/usr/bin/env bash
set -e

function main() {
  shfmt_url="https://github.com/mvdan/sh"

  if ! command -v shfmt > /dev/null; then
    echo "shfmt not found, please install: $shfmt_url" >&2
    exit 1
  fi
  scripts=$(git ls-files --cached --modified --other --exclude-standard --deduplicate -- '*.sh' '*.bash')

  if [ -n "$scripts" ]; then
    printf '%s\n' "$scripts" | parallel --replace --jobs "$(nproc)" shfmt --list "{}" || exit 1
  fi
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
