TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Run A Scan With Gradle" {
  run hab pkg exec ${TEST_PKG_IDENT} gradle --scan
  [ $status -eq 0 ]
}

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} gradle --version | head -n 3 | tail -n 1 | awk '{print $2}' | tr -d ' ')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}
