#!/bin/bash
#
# Usage: test.sh <pkg_ident>
#
# Example: test.sh core/btrfs-progs/5.6.1/20200507194014

set -euo pipefail

PKGIDENT="${1}"
export PKGIDENT

hab pkg install core/bats --binlink
hab pkg install "${PKGIDENT}"
bats "$(dirname "${0}")/test.bats"
