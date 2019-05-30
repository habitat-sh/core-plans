#!/bin/sh

set -eou pipefail

TESTDIR="$(dirname "${0}")"
source "${TESTDIR}/helpers.bash"

if [ -z "${1:-}" ]; then
  echo "Usage: $0 FULLY_QUALIFIED_PACKAGE_IDENT"
  exit 1
fi

TEST_PKG_IDENT="$1"

hab pkg install core/bats --binlink

hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc

# Wait for supervisor to start
hab sup term
hab sup run &
echo "Waiting for supervisor to start"
wait_listen tcp 9632 30


# Unload the service if its already loaded.
hab svc unload "${TEST_PKG_IDENT}"
hab svc load "${TEST_PKG_IDENT}"

# Wait for 30 seconds on first check, to ensure service is up.
echo "Waiting for Artifactory to start"
wait_listen tcp 8081 90

export TEST_PKG_IDENT
bats "${TESTDIR}/test.bats"

hab svc unload "${TEST_PKG_IDENT}"
hab sup term
