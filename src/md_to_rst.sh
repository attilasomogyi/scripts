#!/usr/bin/env bash

function md_to_rts() {
  markdown_file="$1"
  restructuredtext_file="$(basename "${markdown_file%.*}" | sed 's/_/-/g;s/\(.*\)/\L\1/').rst"
  pandoc "$markdown_file" --from gfm --to rst -s -o "$docs_source_pages/$restructuredtext_file"
}

function main() {
  markdown_files=$(git ls-files -- '*.md' ':!:.github/*')
  export docs_source_pages="docs/source/pages"
  export -f md_to_rts
  if [ -n "$markdown_files" ]; then
    printf "%s\n" "$markdown_files" | xargs -n1 -P "$(nproc)" bash -c 'md_to_rts "$@"' _
  fi
}

if [ "$0" == "${BASH_SOURCE[0]}" ]; then
  main
fi
