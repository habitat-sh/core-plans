source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v caddy)" ]
}

@test "Version matches" {
  result="$(caddy --version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run caddy --help
  [ $status -eq 2 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "caddy\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 8080" {
  result="$(netstat -peanut | grep caddy | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 8080 ]
}
