#!/usr/bin/env bash
set -e

function main() {

  html_files=$(git ls-files --cached --modified --other --exclude-standard --deduplicate --recurse-submodules -- '*.html' ':!:*/*template*/*.html')

  if [ -n "$html_files" ]; then
    printf '%s\n' "$html_files" | parallel --replace --jobs "$(nproc)" yarn htmlhint "{}" || exit 1
  fi
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
