#!/bin/bash

set -u

# Don't attempt to build the following plans. They have resource requirements
# or build times that exceed the currently available resources on our CI
# infrastructure.
# See also: #2759 and #2065
PLAN_BLACKLIST=(
 glibc
 gcc
 ghc
 ghc710
 ghc710-bootstrap
 ghc80
 ghc82
 ghc82-bootstrap
 ghc84
 ghc86
 kubernetes
 mongodb
 mysql
 opendistro-for-elasticsearch
)
plan="$(basename "$1")"

HAB_ORIGIN=ci
export HAB_ORIGIN

for bl in "${PLAN_BLACKLIST[@]}"; do
  if [[ "${plan}" == "${bl}" ]]; then
    echo "--- :bangbang: [$plan] Skipping build"
    # If we're running in buildkite, we also want to annotate the build
    if [[ "${CI:-}" == "true" ]]; then
      buildkite-agent annotate --style 'warning' ":bangbang: ${plan} found in build blacklist. Skipping build. "
    fi
    exit 0;
  fi
done


echo "--- :key: Generating fake origin key"
# This is intended to be run in the context of public CI where
# we won't have access to any valid signing keys. j
hab origin key generate "$HAB_ORIGIN"


echo "--- :construction: Starting build for $plan"
# Build with DO_CHECK=true.
# There are a number of plans that have false-positive tests
# or "known failing" tests that are currently ignored by maintainers
# For now this script will be non-enforcing and will always
# return success. It will be on the maintainers to verify the build
# and determine if any failures need correction.  In the future
# this will be turned into an enforcing script, preventing merges
# if do_check produces any failures.

# We want to ensure that we build from the project root. This
# creates a subshell so that the cd will only affect that process
project_root="$(git rev-parse --show-toplevel)"
(
  cd "$project_root"
  env DO_CHECK=true hab pkg build "$plan"
)
status=$?

if [[ $status -ne 0 ]]; then
  echo "--- :rotating_light: :rotating_light: :rotating_light: BUILD FAILED :rotating_light: :rotating_light: :rotating_light:"
fi

exit 0
