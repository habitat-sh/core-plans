#!/bin/bash

set -euo pipefail

#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/opa/0.11.0/20190531065119
#/

TESTDIR="$(dirname "${0}")"

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
  exit 1
fi

TEST_PKG_IDENT="$1"

hab pkg install core/bats --binlink
hab pkg install "${TEST_PKG_IDENT}"

export TEST_PKG_IDENT
bats "${TESTDIR}/test.bats"
