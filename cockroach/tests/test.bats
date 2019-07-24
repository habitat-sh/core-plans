TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} cockroachoss version | head -1 | awk '{print $3}')"
  [ "$result" = "v${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} cockroachoss help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "cockroach\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on ports: 8080, 26257" {
  result="$(netstat -peanut | grep cockroach | awk '{print $4}' | awk -F':' '{print $2}' | grep 8080)"
  [ $? -eq 0 ]
  result="$(netstat -peanut | grep cockroach | awk '{print $4}' | awk -F':' '{print $2}' | grep 26257)"
  [ $? -eq 0 ]
}
