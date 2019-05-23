#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

PKGIDENT="${1}"
export PKGIDENT
hab pkg install core/bats --binlink
hab pkg install core/jdk8
hab pkg install "${PKGIDENT}"
bats "$(dirname "${0}")/test.bats"
