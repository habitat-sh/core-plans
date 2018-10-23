#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install --binlink core/bats

source "${PLANDIR}/plan.sh"

if [ "${SKIPBUILD}" -eq 0 ]; then
  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  source results/last_build.env
  hab pkg install --binlink --force "results/${pkg_artifact}"
  popd > /dev/null
  set +e
fi

PYTHONPATH="$(hab pkg path core/python2)/lib/python2.7/site-packages:$(hab pkg path ${pkg_origin}/ansible)/lib/python2.7/site-packages"
export PYTHONPATH

bats "${TESTDIR}/test.bats"
