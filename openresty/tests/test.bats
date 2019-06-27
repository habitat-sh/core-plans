TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} openresty -v 2>&1 | head -n 1 | awk -F'/' '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "openresty[0-9]*\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 80" {
  result="$(netstat -peanut | grep nginx | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 80 ]
}
