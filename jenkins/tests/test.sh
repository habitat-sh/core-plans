#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install core/bats --binlink
hab pkg install core/jre8 --binlink

hab pkg install core/busybox-static
hab pkg binlink core/busybox-static ps
hab pkg binlink core/busybox-static netstat
hab pkg binlink core/busybox-static wc
hab pkg binlink core/busybox-static uniq

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
  sleep 15
fi

bats "${TESTDIR}/test.bats"
