source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v prometheus)" ]
  [ "$(command -v promtool)" ]
}

@test "Version matches" {
  result="$(prometheus --version 2>&1 | head -n 1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run prometheus --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "prometheus2\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 9090" {
  result="$(netstat -peanut | grep LISTEN | grep prometheus | awk '{print $4}' | tr -d ':')"
  [ "${result}" -eq 9090 ]
}
