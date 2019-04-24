#!/bin/sh

set -euo pipefail

TESTDIR="$(dirname "${0}")"

if [ -z "${1:-}" ]; then
  echo "Usage: tomcat-native/tests/test.sh FULLY_QUALIFIED_PACKAGE_IDENT"
  exit 1
fi

PKG_IDENT="$1"

hab pkg install core/bats

export PKG_IDENT
hab pkg exec core/bats bats "${TESTDIR}/test.bats"
