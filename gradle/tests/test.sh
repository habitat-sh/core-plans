#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

PLANDIR="$(dirname "${0}")"

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install core/openjdk11
hab pkg install "${TEST_PKG_IDENT}"

JAVA_HOME="$(hab pkg path core/openjdk11)"
export JAVA_HOME
bats "$(dirname "${0}")/test.bats"
rm -rf "${PLANDIR}/../.gradle"
