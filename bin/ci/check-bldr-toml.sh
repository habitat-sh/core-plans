#!/usr/bin/env bash
#
# pre-commit hook:
# Check for plans that don't have an entry in our .bldr.toml
#
# Authors:
# - Steven Danna <steve@chef.io>

set -eu

plan_path="$(basename "$1")"

check_bldr_toml_for() {
  local plan_name
  local project_root

  plan_name="$1"
  project_root=$(git rev-parse --show-toplevel)

  if ! grep -Eq "^\[$plan_name\]" "$project_root"/.bldr.toml
  then
    echo "No entry for ${plan_name} in .bldr.toml"
    exit 1
  fi
}

echo "--- :flashlight: [${plan_path}] Checking for .bldr.toml entry"
check_bldr_toml_for "$plan_path"
echo "--- :card_index_dividers: Found [${plan_path}] Found .bldr.toml entry"
