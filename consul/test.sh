#!/bin/sh

test_value() {
  if [ "${1}" -eq "${2}" ]; then
    printf "Pass"
  else
    printf "FAIL"
  fi
}

# Usage: test_listen <protocol> <port> [wait-duration]
# protocol: tcp or udp
# port: int
# wait-duration: time in seconds
test_listen() {
  local proto="-z"
  if [ "${1}" == "udp" ]; then
    proto="-u"
  fi
  local wait=${3:-3}
  nc "${proto}" -w"${wait}" 127.0.0.1 "${2}"
  test_value $? 0
  echo " ... Listening on ${1}/${2}"
}

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
set -e
build
source results/last_build.env
hab pkg install "results/${pkg_artifact}"
hab svc load "${pkg_ident}"
set +e

# Confirm ports listening:
# * tcp: 8300, 8301, 8302, 8500, 8600
# * udp: 8301, 8302, 8600
# Wait for 30 seconds on first check, to ensure service is up.
echo "Waiting for consul to start"
wait_listen tcp 8300 30

echo "---------------------------------------"
echo "Test Output"
echo "---------------------------------------"

test_listen tcp 8300
test_listen tcp 8301
test_listen tcp 8302
test_listen tcp 8500
test_listen tcp 8600
test_listen udp 8301
test_listen udp 8302
test_listen udp 8600
