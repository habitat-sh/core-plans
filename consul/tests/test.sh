#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install --binlink core/bats

hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc

wait_listen() {
  local proto="-z"
  if [ "${1}" == "udp" ]; then
    proto="-u"
  fi
  local wait=${3:-1}
  while ! nc "${proto}" -w"${wait}" 127.0.0.1 "${2}"; do
    sleep 1
  done
}

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
  source results/last_build.env
  hab pkg install --binlink --force "results/${pkg_artifact}"
  hab svc load "${pkg_ident}"
  popd > /dev/null
  set +e
fi

# Wait for 30 seconds on first check, to ensure service is up.
echo "Waiting for consul to start"
wait_listen tcp 8300 30

bats "${TESTDIR}/test.bats"
