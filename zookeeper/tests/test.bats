@test "zookeeper service is running" {
  [ "$(hab svc status | grep "zookeeper\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "zookeeper matches version ${expected_version}" {
  result="$(echo status | nc 127.0.0.1 2181 | grep -oP "(?<=Zookeeper version: )([^-]*)")"
  [ "$result" = "${expected_version}" ]
}
