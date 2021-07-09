TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} coredns -- -version | grep CoreDNS | awk -F'-' '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} coredns -- -help
  [ $status -eq 0 ]
}

@test "Plugin list" {
  run hab pkg exec ${TEST_PKG_IDENT} coredns -- -plugins
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "coredns\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 53" {
  result="$(netstat -peanut | grep coredns | grep udp | awk '{print $4}' | awk -F':' '{print $NF}')"
  [ "${result}" -eq 53 ]
}
