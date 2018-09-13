source "${BATS_TEST_DIRNAME}/../plan.sh"

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
  return $?
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

@test "Port Listen TCP/8300" {
  test_listen tcp 8300
  [ "$?" -eq 0 ]
}

@test "Port Listen TCP/8301" {
  test_listen tcp 8301
  [ "$?" -eq 0 ]
}

@test "Port Listen TCP/8302" {
  test_listen tcp 8302
  [ "$?" -eq 0 ]
}

@test "Port Listen TCP/8500" {
  test_listen tcp 8500
  [ "$?" -eq 0 ]
}

@test "Port Listen TCP/8600" {
  test_listen tcp 8600
  [ "$?" -eq 0 ]
}

@test "Port Listen UDP/8301" {
  test_listen udp 8301
  [ "$?" -eq 0 ]
}

@test "Port Listen UDP/8302" {
  test_listen udp 8302
  [ "$?" -eq 0 ]
}

@test "Port Listen UDP/8600" {
  test_listen udp 8600
  [ "$?" -eq 0 ]
}
