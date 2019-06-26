#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install core/bats --binlink
hab pkg install "core/jre8" --binlink --force

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

JAVA_HOME="$(hab pkg path core/jre8)"
export JAVA_HOME

bats "${TESTDIR}/test.bats"

rm -rf "${PLANDIR}/../.gradle"
