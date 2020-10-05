#!/bin/bash
#
# Usage: test.sh <pkg_ident>
#
# Example: test.sh core/buildah/1.14.8/20200507194711

set -euo pipefail

PKGIDENT="${1}"
export PKGIDENT

hab pkg install core/bats --binlink
hab pkg install "${PKGIDENT}"
bats "$(dirname "${0}")/test.bats"
