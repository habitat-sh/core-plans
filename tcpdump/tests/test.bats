TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} tcpdump --version 2>&1 | head -1 | awk '{print $3}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} tcpdump --help
  [ $status -eq 0 ]
}
