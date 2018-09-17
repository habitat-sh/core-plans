source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v memcached)" ]
}

@test "Version matches" {
  result="$(memcached --version 2>&1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run memcached --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "memcached\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 11211" {
  result="$(netstat -peanut | grep memcached | head -1 | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 11211 ]
}

@test "Contains SASL support" {
  memcached --help | grep "enable-sasl"
  [ $? -eq 0 ]
}
