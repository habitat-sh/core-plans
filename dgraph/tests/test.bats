TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} dgraph version | grep 'Dgraph version' | awk '{print $4}')"
  [ "$result" = "v${TEST_PKG_VERSION}" ]
}

@test "Help command is functional" {
  run hab pkg exec ${TEST_PKG_IDENT} dgraph help
  [ $status -eq 0 ]
}
