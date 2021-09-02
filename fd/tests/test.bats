TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" fd -- --version | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec "${TEST_PKG_IDENT}" fd -- --help
  [ $status -eq 0 ]
}
