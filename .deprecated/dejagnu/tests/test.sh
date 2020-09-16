#!/bin/bash

set -euo pipefail
if [[ -z "${1:-}" ]]; then
  echo "Usage: test.sh <fully qualified package ident>"
  echo
  echo "ex: test.sh core/dejagnu/1.6.1/20181108171344"
  exit 1
fi

pkg_ident=${1}
# This depends on the package being present on the depot OR
# in your local cache. If you're testing locally this is a
# reasonably safe assumption to make, as long as the cache
# isn't cleaned aggressively
hab pkg install "$pkg_ident"
hab pkg install core/bats

# Execute the following in a subshell so that our exports
# don't pollute the studio environment
(
  export pkg_ident
  hab pkg exec core/bats bats "$(dirname "$0")"/test.bats
)
