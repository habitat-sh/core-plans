#!/bin/bash
#
# Usage: test.sh <pkg_ident>
#
# Example: test.sh core/devicemapper/2.03.00/20200507192941

set -euo pipefail

PKGIDENT="${1}"
export PKGIDENT

hab pkg install core/bats --binlink
hab pkg install "${PKGIDENT}"
bats "$(dirname "${0}")/test.bats"
