#!/usr/bin/env bash
set -e

function main() {
  files=$(git ls-files -- '*.json' '*.yml' '*.yaml' ':!:styles/' ':!:.secretlintrc.json' ':!:trivy.yaml' ':!:.vscode/' ':!:.jsonlintrc.json')
  if [ -n "$files" ]; then
    printf "%s\n" "$files" | parallel --replace --jobs "$(nproc)" yarn v8r "{}" || exit 1
  fi
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
