source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v gnatsd)" ]
}

@test "Version matches" {
  result="$(gnatsd -v)"
  [ "$result" = "nats-server version ${pkg_version}" ]
}

@test "Help command" {
  run gnatsd -h
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "gnatsd\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep -v "test" | grep gnatsd | wc -l)"
  [ "${result}" -eq 1 ]
}

@test "Listening on port 8222 (HTTP)" {
  [ "$(netstat -peanut | grep gnatsd | awk '{print $4}' | awk -F':' '{print $2}' | grep 8222)" ]
}

@test "Listening on port 4242 (NATS)" {
  [ "$(netstat -peanut | grep gnatsd | awk '{print $4}' | awk -F':' '{print $2}' | grep 4242)" ]
}
