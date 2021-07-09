TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result=$(hab pkg exec ${TEST_PKG_IDENT} lz4 -- --version | grep "v${TEST_PKG_VERSION}")
  [ $? -eq 0 ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} lz4 -- --help
  [ $status -eq 0 ]
}
