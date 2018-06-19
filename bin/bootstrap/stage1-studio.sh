#!/usr/bin/env bash

# Fail if there are any unset variables and whenever a command returns a
# non-zero exit code.
set -eux

# Skip any `.studiorc` files from loading
export HAB_STUDIO_NOSTUDIORC=true
# Set the Studio type to `stage1`
export STUDIO_TYPE=stage1
# Set a custom Studio root so that it's easier to re-enter later
export HAB_STUDIO_ROOT=/hab/studios/stage1
# Set the origin key to `core`
export HAB_ORIGIN=core

# Do not mount in a shared artifact cache
export NO_ARTIFACT_PATH=true

# Exec the Studio program
exec hab studio "$@"
