#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install --binlink core/bats
hab pkg install --binlink --force "core/jre8"

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

JAVA_HOME="$(hab pkg path core/jre8)"
export JAVA_HOME

bats "${TESTDIR}/test.bats"

rm -rf "${PLANDIR}/../.gradle"
