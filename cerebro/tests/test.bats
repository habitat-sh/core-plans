TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Service is running" {
  [ "$(hab svc status | grep "cerebro\.default" | awk '{print $4}' | grep up)" ]
}

@test "Version matches" {
  result="$(curl http://localhost:9000 | grep appVersion | awk '{print $6}' | tr -d "'\"\>" | tr -d 'v')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}
