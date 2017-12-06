#!/usr/bin/env bash
#
# pre-commit hook:
# Check for plans that don't have an entry in our .bldr.toml
#
# Authors:
# - Steven Danna <steve@chef.io>

set -eu
requested=("$@")

check_bldr_toml_for() {
  plan_path=$1
  plan_name=$(dirname "$plan_path")
  if ! grep -Eq "^\[$plan_name\]" .bldr.toml
  then
    echo "No entry for ${plan_name} in .bldr.toml"
    exit 1
  fi
}

for plan in "${requested[@]}"; do
  check_bldr_toml_for "$plan"
done
