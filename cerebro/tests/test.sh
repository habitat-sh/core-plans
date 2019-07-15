#!/bin/sh
set -euo pipefail

#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

source "$(dirname "${0}")/../../bin/ci/test_helpers.sh"

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install core/curl --binlink
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc
hab pkg binlink core/busybox-static netstat
hab pkg binlink core/busybox-static ps
hab pkg install "${TEST_PKG_IDENT}"

ci_ensure_supervisor_running
ci_load_service "$TEST_PKG_IDENT"

# ensure cerebro http endpoint is working
until (curl -sI http://localhost:9000);do
  echo 'Waiting for cerebro http endpoint to return a 200'
  sleep 2
done

# run the tests
bats "$(dirname "${0}")/test.bats"

# unload the service
hab svc unload "${TEST_PKG_IDENT}" || true
