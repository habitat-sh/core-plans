#!/bin/bash

@test "Help command" {
  run hab pkg exec "${TEST_PKG_IDENT}" sed --help
  [ $status -eq 0 ]
}

substitute_command() {
  echo 'catdogcat' | hab pkg exec "${TEST_PKG_IDENT}" sed s/dog/cat/g
}
@test "Basic text substitution" {
  run substitute_command
  [ "$status" -eq 0 ]
  [ "$output" = 'catcatcat' ]
}


#!/bin/bash
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT
hab pkg install core/bats --binlink
hab pkg install "${TEST_PKG_IDENT}"
bats "$(dirname "${0}")/test.bats"
