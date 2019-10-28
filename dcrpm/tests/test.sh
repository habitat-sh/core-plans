#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/dcrpm/0.5.0/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static ps
hab pkg binlink core/busybox-static wc
hab pkg install "${TEST_PKG_IDENT}"
hab pkg binlink core/db db_recover
hab pkg binlink core/db db_stat
hab pkg binlink core/db db_verify
hab pkg binlink core/lsof lsof
hab pkg binlink core/rpm rpm

bats "$(dirname "${0}")/test.bats"
