#!/bin/bash
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/go/1.24.4/20250205122505
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install "${TEST_PKG_IDENT}"
bats "$(dirname "${0}")/test.bats"
