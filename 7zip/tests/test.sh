#!/bin/sh

set -euo pipefail

TESTDIR="$(dirname "${0}")"

if [ -z "${1:-}" ]; then
  echo "Usage: tomcat-native/tests/test.sh FULLY_QUALIFIED_PACKAGE_IDENT"
  exit 1
fi

TEST_PACKAGE_IDENT="$1"

hab pkg install --binlink core/bats

export TEST_PACKAGE_IDENT
bats "${TESTDIR}/test.bats"
