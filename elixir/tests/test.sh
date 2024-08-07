#!/bin/bash
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
echo "${TEST_PKG_IDENT}"
hab pkg install core/bats --binlink
hab pkg install "${TEST_PKG_IDENT}" --binlink
export LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
bats "$(dirname "${0}")/test.bats"
