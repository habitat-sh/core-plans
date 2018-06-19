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
export DB_PREFIX=stage1-base-
# Path to the base plans list
base_plans="${0%/*}/../../base-plans.txt"
# Path to the build plans program
build_plans_cmd="${0%/*}/../build-plans.sh"

set +x

cmd="record ${DB_PREFIX}set $build_plans_cmd $base_plans"
echo "Running: $cmd"
# Time a recorded session which runs the `build-plans.sh` program
eval "$cmd"
