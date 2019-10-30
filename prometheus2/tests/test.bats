TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} prometheus --version 2>&1 | head -n 1 | awk '{print $3}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} prometheus --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "prometheus2\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 9090" {
  result="$(netstat -peanut | grep LISTEN | grep prometheus | awk '{print $4}' | tr -d ':')"
  [ "${result}" -eq 9090 ]
}
