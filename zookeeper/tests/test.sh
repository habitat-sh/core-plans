#!/bin/sh
set -euo pipefail

#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

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

# ensure supervisor is running
until hab sup status 2>/dev/null; do
  echo "Waiting for supervisor to start..."
  jobs | grep -q "hab sup run &" || hab sup run > /dev/null 2>&1 &
  sleep 2
done

# wait for the service to start
hab svc status "${TEST_PKG_IDENT}" 2>/dev/null || hab svc load "${TEST_PKG_IDENT}"
until nc -z 127.0.0.1 2181; do
  echo "Waiting for service to start..."
  sleep 2
done

# run the tests
bats "$(dirname "${0}")/test.bats"

# unload the service
hab svc unload "${TEST_PKG_IDENT}" || true
