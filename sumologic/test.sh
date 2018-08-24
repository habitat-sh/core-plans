#!/bin/sh

# Wait for supervisor to start
echo "Waiting for supervisor to start"
wait_listen tcp 9632 30

# Ensure environment is clean for service testing
source ./plan.sh
hab svc unload "${HAB_ORIGIN}/${pkg_name}"

# Build and install
set -e
build
source results/last_build.env
hab pkg install "results/${pkg_artifact}"
hab svc load "${pkg_ident}"
set +e
