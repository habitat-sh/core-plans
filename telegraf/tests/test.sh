#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install core/bats --binlink

if [ "${SKIPBUILD}" -eq 0 ]; then
  source "${PLANDIR}/plan.sh"
  # Unload the service if its already loaded.
  hab svc unload "${HAB_ORIGIN}/${pkg_name}"

  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  source results/last_build.env
  hab pkg install --binlink --force "results/${pkg_artifact}"
  hab svc load "${pkg_ident}"
  popd > /dev/null
  set +e

  # Wait for service to start
  sleep 10
fi

bats "${TESTDIR}/test.bats"
