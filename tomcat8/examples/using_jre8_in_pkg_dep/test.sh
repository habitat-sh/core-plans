#!/bin/sh

set -euo pipefail

TESTDIR="$(dirname "${0}")"

if [ -z "${1:-}" ]; then
  echo "Usage: $0 FULLY_QUALIFIED_PACKAGE_IDENT"
  exit 1
fi

TEST_PKG_IDENT="$1"

hab pkg install --binlink core/bats
hab pkg install --binlink core/curl
hab pkg install "$TEST_PKG_IDENT"

# load the service
result="$(hab svc status)"
until [[ "${result}" != "No services loaded." ]]
do
  hab svc load $TEST_PKG_IDENT
  sleep 5
  result="$(hab svc status)"
done


export TEST_PKG_IDENT
bats "${TESTDIR}/test.bats"
