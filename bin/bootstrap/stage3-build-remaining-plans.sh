#!/bin/bash

# Load in the `record()` function
# shellcheck disable=SC1091
source /etc/profile

# Fail if there are any unset variables and whenever a command returns a
# non-zero exit code.
set -eux

# Use the build program directly from the Habitat source tree
export BUILD=/src/habitat/components/plan-build/bin/hab-plan-build.sh
# Don't download and/or install any external Habitat packages
export NO_INSTALL_DEPS=true
# Set a prefix for the state file and log names
export DB_PREFIX=stage3-world-
# Path to the build plans program
build_plans_cmd="${0%/*}/../build-plans.sh"

set +x

_print_help() {
  echo "Usage: $(basename "$0") <WORLD_PLANS_FILE>"
}

if [[ -z "${1:-}" ]]; then
  >&2 echo "Invalid use"
  _print_help
  exit 1
else
  case "$1" in
    --help|-h)
      _print_help
      exit 0
      ;;
    -*)
      >&2 echo "Invalid argument: $1, aborting"
      _print_help
      exit 1
      ;;
    *)
      if [[ ! -f "$1" ]]; then
        >&2 echo "No input file found: $1, aborting"
        exit 9
      fi
      plans="$1"
      ;;
  esac
fi

cmd="record ${DB_PREFIX}set $build_plans_cmd $plans"
echo "Running: $cmd"
# Time a recorded session which runs the `build-base-plans.sh` program
eval "$cmd"
