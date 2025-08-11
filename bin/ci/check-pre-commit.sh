#!/usr/bin/env bash

set -eu

plan_path="$(basename "$1")"

echo "--- :python: Install pre-commit"
if [[ "${CI:-}" == "true" ]]; then
  # for  Ubuntu 20.04 (Focal Fossa) and later we have to add the PostgreSQL repository
  # to install the pre-commit package
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt update
  sudo apt install -y python3-pip
  sudo pip3 install pre-commit
else
  echo "Not in CI! Skipping installation of pre-commit. Please install it manually if executing this on your workstation"
fi
pre-commit --version

echo "--- :git: [${plan_path}] Running checks provided by pre-commit hooks"
find "$plan_path" -type f -print0 | xargs -0 pre-commit run --files
