TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} grafana-server -v 2>&1 | head -n 1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "grafana\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 80" {
  result="$(netstat -peanut | grep LISTEN | grep grafana| awk '{print $4}' | tr -d ':')"
  [ "${result}" -eq 80 ]
}
