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
  hab pkg install --binlink --force "results/${pkg_artifact}"
  hab svc load "${pkg_ident}"
  popd > /dev/null
  set +e

  # Give some time for the service to start up
  local _seconds=20
  echo "Waiting for ${pkg_name} to start up (${_seconds} seconds)"
  sleep ${_seconds}
fi

hab pkg install --binlink core/coreutils-static
hab pkg install --binlink core/glibc
hab pkg install --binlink core/jre8
hab pkg install --binlink core/wget
hab pkg install --binlink core/curl
hab pkg install --binlink core/busybox-static

hab pkg install --binlink core/bats

bats "${TESTDIR}/test.bats"
