#!/bin/sh

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

hab pkg install core/busybox-static
hab pkg binlink core/busybox-static nc

# Wait for supervisor to start
echo "Waiting for supervisor to start"
wait_listen tcp 9632 30

# Ensure environment is clean for service testing
source ./plan.sh
hab svc unload "${HAB_ORIGIN}/${pkg_name}"

# Build and install
echo "------------------------------"
echo "Starting Build Test"
echo "------------------------------"
set -e
build
source results/last_build.env
hab pkg install "results/${pkg_artifact}"
hab svc load "${pkg_ident}"
hab pkg exec "${pkg_ident}" wrapper --help
set +e
