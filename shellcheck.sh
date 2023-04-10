#!/usr/bin/env bash
set -e

function main() {
  shellcheck_url="https://github.com/koalaman/shellcheck"

  if ! command -v shellcheck > /dev/null; then
    echo "shellcheck not found, please install: $shellcheck_url" >&2
    exit 1
  fi
  scripts=$(git ls-files --cached --modified --other --exclude-standard --deduplicate -- '*.sh' '*.bash')

  if [ -n "$scripts" ]; then
    printf '%s\n' "$scripts" | parallel --replace --jobs "$(nproc)" shellcheck "{}" || exit 1
  fi
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
