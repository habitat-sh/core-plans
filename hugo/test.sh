#!/bin/sh

SKIPBUILD=${SKIPBUILD:-0}

hab pkg install --binlink core/bats
source ./plan.sh

if [ "${SKIPBUILD}" -eq 0 ]; then
  set -e
  build
  source results/last_build.env
  hab pkg install --binlink --force "results/${pkg_artifact}"
  set +e
fi

bats test.bats
