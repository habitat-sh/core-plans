TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} memcached --version 2>&1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} memcached --help
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
  hab pkg exec ${TEST_PKG_IDENT} memcached --help | grep "enable-sasl"
  [ $? -eq 0 ]
}
