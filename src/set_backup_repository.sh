#!/usr/bin/env bash
set -e

function usage() {
  echo "Usage: $0 [--username <username>]" 1>&2
  exit 1
}

function git_remote_set_url_add_push_origin() {
  git_url="$1"
  git config --get-all remote.origin.pushurl | grep --quiet "$git_url" \
    || git remote set-url --add --push origin "$git_url"
}

function main() {
  options=$(getopt --name "$0" --options u: --longoptions username: -- "$@") || usage
  eval set -- "$options"
  while true; do
    case "$1" in
      --username)
        shift
        username="$1"
        break
        ;;
      --)
        shift
        ;;
      *)
        usage
        ;;
    esac
  done
  repository_name="$(basename "$(git rev-parse --show-toplevel)")"
  github_repository_url="git@github.com:${username}/${repository_name}.git"
  gitlab_repository_url="git@gitlab.com:${username}/${repository_name}.git"
  bitbucket_repository_url="git@bitbucket.org:${username}/${repository_name}.git"
  export -f git_remote_set_url_add_push_origin
  printf "%s" "${github_repository_url} ${gitlab_repository_url} ${bitbucket_repository_url}" | parallel --delimiter ' ' --replace --jobs "$(nproc)" git_remote_set_url_add_push_origin "{}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
