TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} caddy -version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} caddy -help
  [ $status -eq 2 ]
}

@test "Basic config validation" {
  run hab pkg exec ${TEST_PKG_IDENT} caddy -validate
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "caddy\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 8080" {
  result="$(netstat -peanut | grep caddy | head -1 | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 8080 ]
}

@test "Simple cURL request" {
  result="$(curl -vvv http://localhost:8080 2>&1 | grep Server | tr -d '\r')"
  [ "${result}" = "< Server: Caddy" ]
}
