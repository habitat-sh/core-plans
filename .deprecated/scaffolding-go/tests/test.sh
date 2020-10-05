#!/bin/sh
#/ Usage: test.sh <pkg_ident>

set -euo pipefail

TESTDIR="$(dirname "${0}")"

if [ -z "${1:-}" ]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

hab pkg install "${1}"

# Testing Go Path apps
build "${TESTDIR}/go-path-app"
source "results/last_build.env"
hab pkg install -b -f "results/${pkg_artifact}"
go-path-app

# Testing Go Module apps
build "${TESTDIR}/go-module-app"
source "results/last_build.env"
hab pkg install -b -f "results/${pkg_artifact}"
go-module-app
