#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -eou pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TESTDIR="$(dirname "${0}")"
source "${TESTDIR}/helpers.bash"

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc
hab pkg install "${TEST_PKG_IDENT}"

hab sup term
hab sup run &
echo "Waiting for supervisor to start"
wait_listen tcp 9632 30

hab svc load "${TEST_PKG_IDENT}"

# Wait for 30 seconds on first check, to ensure service is up.
echo "Waiting for Artifactory to start"
wait_listen tcp 8081 90

bats "${TESTDIR}/test.bats"

hab svc unload "${TEST_PKG_IDENT}" || true
