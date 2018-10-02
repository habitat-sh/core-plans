source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v cockroach)" ]
}

@test "Version matches" {
  result="$(cockroach version | head -1 | awk '{print $3}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Help command" {
  run cockroach help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "cockroach\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 11211" {
  result="$(netstat -peanut | grep memcached | head -1 | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 11211 ]
}

@test "Contains SASL support" {
  memcached --help | grep "enable-sasl"
  [ $? -eq 0 ]
}
