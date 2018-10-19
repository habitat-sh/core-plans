source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v httpd)" ]
}

@test "Version matches" {
  result="$(httpd -v | head -1 | awk '{print $3}')"
  [ "$result" = "Apache/${pkg_version}" ]
}

@test "Help command" {
  run httpd -h
  # httpd help command exits with status 1, for some reason
  [ $status -eq 1 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "httpd\.default" | awk '{print $4}' | grep up)" ]
}

# Check for processes, exclude grep, and test.bats processes
@test "Multiple processes" {
  result="$(ps aux | grep -v grep | grep -v "test\.bats" | grep httpd | wc -l)"
  [ "${result}" -gt 1 ]
}

@test "Listening on port 80" {
  result="$(netstat -peanut | grep httpd | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 80 ]
}
