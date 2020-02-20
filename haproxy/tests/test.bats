TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} haproxy -v 2>&1 | head -n 1 | awk '{print $3}' | \
    awk --field-separator '-' '{print $1}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Service is running" {
  echo -e "$(hab svc status)"
  [ "$(hab svc status | grep "haproxy[0-9]*\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 80" {
  result="$(netstat -peanut | grep haproxy | awk '{print $4}' | awk -F':' '{print $2}')"
  [ "${result}" -eq 80 ]
}

@test "Contains Prometheus exporter support" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} haproxy -vv 2>&1 | grep "Built with the Prometheus exporter as a service")"
  [ "$result" = "Built with the Prometheus exporter as a service" ]
}
