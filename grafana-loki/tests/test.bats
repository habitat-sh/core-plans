TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Service is running" {
  [ "$(hab svc status | grep "grafana-loki\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 3100" {
  result="$(netstat -peanut | grep LISTEN | grep loki | grep 3100 | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 3100 ]
}

@test "Listening on port 9095" {
  result="$(netstat -peanut | grep LISTEN | grep loki | grep 9095 | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 9095 ]
}
