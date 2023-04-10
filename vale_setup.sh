#!/usr/bin/env bash

set -e

function main() {
  vale sync || exit 1
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
