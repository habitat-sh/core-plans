#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/opa/0.11.0/20190531065119
#/

set -euo pipefail

TESTDIR="$(dirname "${0}")"

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
  exit 1
fi

TEST_PKG_IDENT="$1"

hab pkg install core/bats --binlink
hab pkg install "${TEST_PKG_IDENT}" -b

export TEST_PKG_IDENT
bats "${TESTDIR}/test.bats"
