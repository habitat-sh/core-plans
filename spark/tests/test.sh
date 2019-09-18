#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -euo pipefail

source "$(dirname "${0}")/../../bin/ci/test_helpers.sh"

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc
hab pkg binlink core/busybox-static netstat
hab pkg binlink core/busybox-static ifconfig
hab pkg install core/iproute2
hab pkg binlink core/iproute2 ip
hab pkg install "${TEST_PKG_IDENT}"

ci_ensure_supervisor_running
ci_load_service "$TEST_PKG_IDENT"
ci_wait_for_port 6066

# run the tests
bats "$(dirname "${0}")/test.bats"

# unload the service
hab svc unload "${TEST_PKG_IDENT}" || true
