#!/bin/bash
#
# Usage: test.sh <pkg_ident>
#
# Example: test.sh core/runc/1.0.0-rc10/20200507191843

set -euo pipefail

PKGIDENT="${1}"
export PKGIDENT

hab pkg install core/bats --binlink
hab pkg install core/binutils # for strings
hab pkg install core/file # for file
hab pkg install "${PKGIDENT}"
bats "$(dirname "${0}")/test.bats"
