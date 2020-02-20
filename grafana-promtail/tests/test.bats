TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Service is running" {
  [ "$(hab svc status | grep "grafana-promtail\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 9080" {
  result="$(netstat -peanut | grep LISTEN | grep promtail | grep 9080 | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 9080 ]
}
