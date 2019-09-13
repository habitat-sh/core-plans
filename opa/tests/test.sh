#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/opa/0.11.0/20190531065119
#/

set -euo pipefail

source "$(dirname "${0}")/../../bin/ci/test_helpers.sh"

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
  exit 1
fi

TESTDIR="$(dirname "${0}")"
source "${TESTDIR}/helpers.bash"

export TEST_PKG_IDENT="${1}"
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc
hab pkg install core/bats core/curl core/jq-static --binlink
hab pkg install "${TEST_PKG_IDENT}"

ci_ensure_supervisor_running
ci_load_service "${TEST_PKG_IDENT}"

# Wait for 5 seconds on first check, to ensure service is up.
echo "Waiting for opa to start (5s)"
wait_listen tcp 8181 5

bats "${TESTDIR}/test.bats"

hab svc unload "${TEST_PKG_IDENT}" || true
