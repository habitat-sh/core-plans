#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install core/bats --binlink

source "${PLANDIR}/plan.sh"

if [ "${SKIPBUILD}" -eq 0 ]; then
  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  source results/last_build.env
  hab pkg install "results/${pkg_artifact}" --binlink --force
  popd > /dev/null
  set +e
fi

bats "${TESTDIR}/test.bats"
