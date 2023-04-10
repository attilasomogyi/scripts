#!/usr/bin/env bash
set -e

function main() {

  css_files=$(git ls-files --cached --modified --other --exclude-standard --deduplicate -- '*.css')

  if [ -n "$css_files" ]; then
    printf '%s\n' "$css_files" | parallel --replace --jobs "$(nproc)" yarn stylelint "{}" || exit 1
  fi
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
