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

# clear the supervisor output
export SUP_LOG="/hab/sup/default/sup.log"
cat /dev/null > "${SUP_LOG}"

ci_load_service "core/zookeeper"

# wait for the service to start
countdown=50
hab svc status "${TEST_PKG_IDENT}" 2>/dev/null || hab svc load "${TEST_PKG_IDENT}" --bind zookeeper:zookeeper.default
until ( (nc -z localhost 9092) && (grep -q "INFO Kafka version :" "${SUP_LOG}" ) ) \
  || (( countdown <= 0 )); do
  echo "Waiting for core/kafka service to start ${countdown}"
  sleep 2
  countdown=$((countdown-1))
done

# run the tests
bats "$(dirname "${0}")/test.bats"

# unload the services
hab svc unload "${TEST_PKG_IDENT}" || true
hab svc unload core/zookeeper || true
