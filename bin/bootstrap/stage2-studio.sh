#!/usr/bin/env bash

# Fail if there are any unset variables and whenever a command returns a
# non-zero exit code.
set -eux

# Skip any `.studiorc` files from loading
export HAB_STUDIO_NOSTUDIORC=true
# Set the Studio type to `default`
export STUDIO_TYPE=default
# Set a custom Studio root so that it's easier to re-enter later
export HAB_STUDIO_ROOT=/hab/studios/stage2
# Set the origin key to `core`
export HAB_ORIGIN=core

# Disable any install and running of the Supervisor
export HAB_STUDIO_SUP=false

if [[ "$*" == "new" ]] ; then
  export ARTIFACT_PATH=./results-stage1
else
  # Do not mount in a shared artifact cache
  export NO_ARTIFACT_PATH=true
fi

# Exec the Studio program
exec hab studio "$@"
