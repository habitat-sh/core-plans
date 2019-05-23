#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

source "${PLANDIR}/plan.sh"

if [ "${SKIPBUILD}" -eq 0 ]; then
  # Unload the service if its already loaded.
  hab svc unload "${HAB_ORIGIN}/${pkg_name}"

  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  source results/last_build.env
  hab pkg install "results/${pkg_artifact}" --binlink --force
  hab svc load "${pkg_ident}"
  popd > /dev/null
  set +e

  # Give some time for the service to start up
  local _seconds=20
  echo "Waiting for ${pkg_name} to start up (${_seconds} seconds)"
  sleep ${_seconds}
fi

hab pkg install core/coreutils-static --binlink
hab pkg install core/glibc --binlink
hab pkg install core/jre8 --binlink
hab pkg install core/wget --binlink
hab pkg install core/curl --binlink
hab pkg install core/busybox-static --binlink

hab pkg install core/bats --binlink

bats "${TESTDIR}/test.bats"
