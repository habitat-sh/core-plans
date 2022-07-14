#!/bin/bash

set -euo pipefail

TESTDIR="$(dirname "${0}")"

if [ -z "${1:-}" ]; then
  echo "Usage: $0 FULLY_QUALIFIED_PACKAGE_IDENT"
  exit 1
fi

TEST_PKG_IDENT="$1"

hab pkg install --binlink core/bats
hab pkg install "$TEST_PKG_IDENT"

export TEST_PKG_IDENT
bats "${TESTDIR}/test.bats"
