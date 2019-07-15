@test "Service is running" {
  [ "$(hab svc status | grep "cerebro\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "Version matches" {
  result="$(curl http://localhost:9000 | grep appVersion | awk '{print $6}' | tr -d "'\"\>" | tr -d 'v')"
  [ "$result" = "${expected_version}" ]
}
