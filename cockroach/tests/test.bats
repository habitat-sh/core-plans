source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v cockroachoss)" ]
}

@test "Version matches" {
  result="$(cockroachoss version | head -1 | awk '{print $3}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Help command" {
  run cockroachoss help
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
