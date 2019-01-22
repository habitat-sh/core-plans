#!/bin/bash
# shellcheck disable=SC2034,SC2154,SC1090

# Only set exit-on-error. No other values should be set.
set -e

# Simulate a stage1 build to get any special base plan build dependency lists
STUDIO_TYPE=stage1
# Some base plans use this value if they need to be built twice, simulate first
# pas
FIRST_PASS=true
# Provide an absolute `PLAN_CONTEXT` path for any Plans that require it
PLAN_CONTEXT="$(pwd)/$(dirname "$1")"
SRC_PATH="$PLAN_CONTEXT/.."

# Change directory into the `PLAN_CONTEXT` directory, just like the build
# progra
cd "$(dirname "$1")"

# Load the Plan
source "$(basename "$1")"

# Echo the `<pkg_origin>/<pkg_name>` package identifier on the first line
echo "${pkg_origin:-${HAB_ORIGIN:-unknown}}/${pkg_name}"
# Echo all buildtime and runtime dependent package identifiers on the second
# line
echo "${pkg_build_deps[*]} ${pkg_deps[*]} $pkg_scaffolding"

exit 0
