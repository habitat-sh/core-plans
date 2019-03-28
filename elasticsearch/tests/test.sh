#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install --binlink core/bats
hab pkg install --binlink core/which
hab pkg install --binlink core/jre8
hab pkg install --binlink core/curl
hab pkg install --binlink core/jq-static

hab pkg install core/busybox-static
hab pkg binlink core/busybox-static ps
hab pkg binlink core/busybox-static nc
hab pkg binlink core/busybox-static netstat

source "${PLANDIR}/plan.sh"

if [ "${SKIPBUILD}" -eq 0 ]; then
  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  source results/last_build.env
  hab pkg install --binlink --force "results/${pkg_artifact}"
  hab svc load "${pkg_ident}"
  popd > /dev/null
  set +e

  # Give some time for the service to start up
  sleep 30
fi

bats "${TESTDIR}/test.bats"
