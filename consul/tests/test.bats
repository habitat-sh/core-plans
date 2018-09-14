source "${BATS_TEST_DIRNAME}/../plan.sh"
load helpers

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
