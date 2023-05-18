#!/usr/bin/env bash
set -e

function main() {
  languagetool \
    --language en-US \
    --disable WHITESPACE_RULE,HELL,ARROWS,SENTENCE_WHITESPACE,GITHUB,NODE_JS \
    "$@"
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main "$@"
fi
