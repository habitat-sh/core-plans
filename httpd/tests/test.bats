TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} httpd -v | head -1 | awk '{print $3}')"
  [ "$result" = "Apache/${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} -- httpd -h
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
  result="$(netstat -peanut | grep httpd | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 80 ]
}
