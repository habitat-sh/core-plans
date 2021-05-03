#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static ps
hab pkg binlink core/busybox-static wc
hab pkg install "${TEST_PKG_IDENT}"


hab sup term
hab sup run &
sleep 5
hab svc load "${TEST_PKG_IDENT}"

# Allow service start
WAIT_SECONDS=5
echo "Waiting ${WAIT_SECONDS} seconds for service to start..."
sleep "${WAIT_SECONDS}"

bats "$(dirname "${0}")/test.bats"

hab svc unload "${TEST_PKG_IDENT}" || true
