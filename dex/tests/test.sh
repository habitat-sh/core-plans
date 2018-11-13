#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

source "${TESTDIR}/helpers.bash"

hab pkg install --binlink core/bats

hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc
hab pkg install -b core/jq-static core/curl

# Wait for supervisor to start
echo "Waiting for supervisor to start"
wait_listen tcp 9632 30

source "${PLANDIR}/plan.sh"
# Unload the service if its already loaded.
hab svc unload "${HAB_ORIGIN}/${pkg_name}"

if [ "${SKIPBUILD}" -eq 0 ]; then
  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  popd > /dev/null
  set +e
fi

source "${PLANDIR}/results/last_build.env"
hab pkg install --binlink --force "${PLANDIR}/results/${pkg_artifact}"
hab svc load "${pkg_ident}"

# Wait for 5 seconds on first check, to ensure service is up.
echo "Waiting for dex to start (5s)"
wait_listen tcp 5556 5

bats "${TESTDIR}/test.bats"
