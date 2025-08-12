#!/usr/bin/env bash

set -eu

plan_path="$(basename "$1")"

echo "--- :python: Install pre-commit"
if [[ "${CI:-}" == "true" ]]; then
  sudo apt-get update
  sudo apt-get install -y python3-pip
  pip3 install --user pre-commit
else
  echo "Not in CI! Skipping installation of pre-commit. Please install it manually if executing this on your workstation"
fi
pre-commit --version

echo "--- :git: [${plan_path}] Running checks provided by pre-commit hooks"
find "$plan_path" -type f -print0 | xargs -0 pre-commit run --files
