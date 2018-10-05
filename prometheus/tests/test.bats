source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v prometheus)" ]
  [ "$(command -v promtool)" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "prometheus\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 9090" {
  result="$(netstat -peanut | grep prometheus | grep LISTEN | head -1 | awk '{print $4}' | awk -F':::' '{print $2}')"
  [ "${result}" -eq 9090 ]
}
