#!/bin/bash

set -euo pipefail

if [ -z "${1:-}" ]; then
	echo "Usage: handlebars-cmd/tests/test.sh FULLY_QUALIFIED_PACKAGE_IDENTIFIER"
	exit 1
fi

pkg_ident="$1"

hab pkg install core/bats
hab pkg install "${pkg_ident}"

tests_path="$(dirname "$0")"

export pkg_ident
hab pkg exec core/bats bats "$tests_path"/bats/test.bats
