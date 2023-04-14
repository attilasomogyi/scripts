#!/usr/bin/env bash
set -e

yarn lint-staged
git submodule foreach --recursive yarn lint-staged
