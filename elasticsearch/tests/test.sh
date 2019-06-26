#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install core/bats --binlink
hab pkg install core/which --binlink
hab pkg install core/jre8 --binlink
hab pkg install core/curl --binlink
hab pkg install core/jq-static --binlink

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
  hab pkg install "results/${pkg_artifact}" --binlink --force
  hab svc load "${pkg_ident}"
  popd > /dev/null
  set +e

  # Give some time for the service to start up
  sleep 30
fi

bats "${TESTDIR}/test.bats"
