source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v elasticsearch)" ]
}

@test "Version matches" {
  result="$(elasticsearch --version | awk -F',' '{print $1}')"
  [ "$result" = "Version: ${pkg_version}" ]
}

@test "Help command" {
  run elasticsearch --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "elasticsearch5\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep -v "test" | grep elasticsearch5 | wc -l)"
  [ "${result}" -eq 1 ]
}

@test "Listening on ports 9200, 9300" {
  [ "$(netstat -peanut | grep java | awk '{print $4}' | awk -F':' '{print $2}' | grep 9200)" ]
  [ "$(netstat -peanut | grep java | awk '{print $4}' | awk -F':' '{print $2}' | grep 9300)" ]
}
