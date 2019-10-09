#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/asciinema/2.0.2/20181108151533
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

# asciinema requires locale to be set to either ASCII or UTF-8
export LC_ALL=en_US.UTF-8

bats "$(dirname "${0}")/test.bats"
