TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} ansible -- --version | head -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help Command" {
  run hab pkg exec ${TEST_PKG_IDENT} ansible -- --help
  [ $status -eq 0 ]
}
