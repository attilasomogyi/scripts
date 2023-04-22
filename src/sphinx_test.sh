#!/bin/usr/env bash

set -e

function main() {
  docs_dir="docs/"
  bash -e scripts/md_to_rst.sh || exit 1
  make -C "$docs_dir" -j"$(nproc)" -b html || exit 1
  make -C "$docs_dir" -j"$(nproc)" -b linkcheck || exit 1
  make -C "$docs_dir" -j"$(nproc)" -b clean || exit 1
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
