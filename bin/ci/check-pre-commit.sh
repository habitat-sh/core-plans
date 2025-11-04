#!/usr/bin/env bash

set -eu

plan_path="$(basename "$1")"

echo "--- :python: Install pre-commit"
if [[ "${CI:-}" == "true" ]]; then
  # Temporarily disable problematic third-party repos to avoid apt errors
  sudo mv /etc/apt/sources.list.d/helm-stable-debian.list /tmp/ 2>/dev/null || true
  sudo mv /etc/apt/sources.list.d/pgdg.list /tmp/ 2>/dev/null || true

  # Switch to old-releases mirror (since focal is now ESM/archived)
  sudo sed -i 's|http://archive.ubuntu.com/ubuntu/|http://old-releases.ubuntu.com/ubuntu/|g' /etc/apt/sources.list
  sudo sed -i 's|http://security.ubuntu.com/ubuntu|http://old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list
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
