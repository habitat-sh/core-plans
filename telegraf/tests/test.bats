TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} telegraf version | head -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "telegraf\.default" | awk '{print $4}' | grep up)" ]
}
