#!/usr/bin/env bash
set -e

git config fetch.prune true
git config push.recurseSubmodules on-demand
git config submodule.recurse true
git config status.submoduleSummary true
git config diff.submodule log
