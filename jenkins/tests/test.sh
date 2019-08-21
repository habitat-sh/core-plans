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
hab pkg install core/openjdk11 --binlink
hab pkg install core/curl --binlink
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc
hab pkg binlink core/busybox-static netstat
hab pkg binlink core/busybox-static ifconfig
hab pkg install core/iproute2
hab pkg binlink core/iproute2 ip

hab pkg install "${TEST_PKG_IDENT}"

ci_ensure_supervisor_running
ci_load_service "${TEST_PKG_IDENT}"

# wait for the service to start
DEFAULT_INTERFACE="$(ip route list | grep "default"  | awk '{print $5}')"
ETH0_IP_ADDRESS="$(ifconfig "${DEFAULT_INTERFACE}" | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1)"
until nc -z "${ETH0_IP_ADDRESS}" 80; do
  echo "Waiting for jenkins endpoint to be ready"
  sleep 2
done

# run the tests
bats "$(dirname "${0}")/test.bats"

# unload the service
hab svc unload "${TEST_PKG_IDENT}" || true
