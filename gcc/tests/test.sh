#!/bin/bash

set -euo pipefail

TESTDIR="$(dirname "$0")"


TEST_PKG_IDENT="$1"

hab pkg install core/bats --binlink
hab pkg install "$TEST_PKG_IDENT"


export TEST_PKG_IDENT
bats "${TESTDIR}/bats/test.bats" --tap
