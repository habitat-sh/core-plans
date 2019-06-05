#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/grpcurl/1.3.0/20190531065119
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
  exit 1
fi

export TEST_PKG_IDENT="${1}"
hab pkg install core/bats --binlink
hab pkg install "${TEST_PKG_IDENT}"
bats "$(dirname "${0}")/test.bats"
