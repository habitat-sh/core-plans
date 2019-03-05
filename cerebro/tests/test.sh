#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install --binlink core/bats
hab pkg install --binlink "core/curl"

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

hab svc load "${pkg_ident}"
hab svc start "${pkg_ident}"
sleep 120

bats "${TESTDIR}/test.bats"

hab svc unload "${pkg_ident}"
