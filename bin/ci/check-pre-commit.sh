#!/usr/bin/env bash

set -eu

plan_path="$(basename "$1")"

echo "--- :python: Install pre-commit"
if [[ "${CI:-}" == "true" ]]; then
  # Remove PostgreSQL apt repo if present (focal-pgdg is broken)
  if grep -R "apt.postgresql.org.*focal-pgdg" /etc/apt/sources.list /etc/apt/sources.list.d/ >/dev/null 2>&1; then
    echo "Removing broken PostgreSQL PGDG repo for focal..."
    sudo sed -i '/apt.postgresql.org.*focal-pgdg/d' /etc/apt/sources.list || true
    sudo find /etc/apt/sources.list.d/ -type f -exec sed -i '/apt.postgresql.org.*focal-pgdg/d' {} \; || true
  fi
  apt-get clean -y
  apt-get update -y
  apt-get install -y python3-pip
  pip3 install pre-commit
else
  echo "Not in CI! Skipping installation of pre-commit. Please install it manually if executing this on your workstation"
fi
pre-commit --version

echo "--- :git: [${plan_path}] Running checks provided by pre-commit hooks"
find "$plan_path" -type f -print0 | xargs -0 pre-commit run --files
