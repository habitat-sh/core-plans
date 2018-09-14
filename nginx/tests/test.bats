source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v nginx)" ]
}

@test "Version matches" {
  result="$(nginx -v 2>&1 | awk -F'/' '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run nginx -h
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "nginx\.default" | awk '{print $4}' | grep up)" ]
}

# Check for master process, exclude grep, and test.bats processes
@test "A single master process" {
  result="$(ps aux | grep -v grep | grep -v "test\.bats" | grep nginx | grep master | wc -l)"
  [ "${result}" -eq 1 ]

  result="$(ps aux | grep -v grep | grep -v "test\.bats" | grep nginx | grep master | awk '{print $2}')"
  [ "${result}" = "root" ]
}

# Check for worker processes, exclude grep, and test.bats processes
@test "Multiple worker processes" {
  result="$(ps aux | grep -v grep | grep -v "test\.bats" | grep nginx | grep worker | wc -l)"
  [ "${result}" -gt 1 ]

  result="$(ps aux | grep -v grep | grep -v "test\.bats" | grep nginx | grep worker | awk '{print $2}' | uniq)"
  [ "${result}" = "hab" ]
}

@test "Listening on port 80" {
  result="$(netstat -peanut | grep nginx | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 80 ]
}
