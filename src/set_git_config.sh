#!/usr/bin/env bash
set -e

git config fetch.prune true
git config push.recurseSubmodules on-demand
git config submodule.recurse true
git config --global status.submoduleSummary true
git config --global diff.submodule log
