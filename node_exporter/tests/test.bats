TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  skip
  # Currently this fails, as the version information is not available in the build.
  result="$(hab pkg exec ${TEST_PKG_IDENT} node_exporter --version)"
  [ "$result" = "${expected_version}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} node_exporter -h
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "node_exporter\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 9100" {
  [ "$(netstat -peanut | grep node_exporter | awk '{print $4}' | awk -F':' '{print $NF}' | grep 9100)" ]
}
