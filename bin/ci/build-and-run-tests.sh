#!/bin/bash

set -eou pipefail

# Don't attempt to build the following plans. They have resource requirements
# or build times that exceed the currently available resources on our CI
# infrastructure.
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
# we won't have access to any valid signing keys.
hab origin key generate "$HAB_ORIGIN"

echo "--- :construction: Starting build for $plan"
# We want to ensure that we build from the project root. This
# creates a subshell so that the cd will only affect that process
project_root="$(git rev-parse --show-toplevel)"
(
  cd "$project_root"
  echo "--- :construction: Building $plan"
  env DO_CHECK=true hab pkg build "$plan"
  source results/last_build.env
  echo "--- :mag: Testing $pkg_ident"
  if [ ! -f "$plan/tests/test.sh" ]; then
    buildkite-agent annotate --style 'warning' ":warning: :linux: ${plan} has no Linux tests to run. This is currently permitted but please consider adding some tests."
    # TODO: At some point, change this to 1 and hard fail the build
    exit 0
  fi
  # Need to rename the studio because studios cannot be re-entered due to umount issues.
  # Ref: https://github.com/habitat-sh/habitat/issues/6577
  hab studio -q -r "/hab/studios/verify-build-$pkg_name-$pkg_version-$pkg_release" run "./$plan/tests/test.sh $pkg_ident"
)
