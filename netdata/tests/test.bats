TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} netdata -v | awk '{print $2}')"
  [ "$result" = "v${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} netdata -h
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "netdata\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 19999" {
  result="$(netstat -peanut | grep netdata | grep 19999 | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 19999 ]
}
