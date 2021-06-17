TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} sccache -- --version | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} sccache -- --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "sccache\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 4226" {
  result="$(netstat -peanut | grep sccache | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 4226 ]
}
