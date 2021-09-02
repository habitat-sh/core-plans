TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Package, Server, Client and API Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" sensu-client -- --version)"
  [ "$result" = "${TEST_PKG_VERSION}" ]

  result="$(hab pkg exec "${TEST_PKG_IDENT}" sensu-api -- --version)"
  [ "$result" = "${TEST_PKG_VERSION}" ]

  result="$(hab pkg exec "${TEST_PKG_IDENT}" sensu-server -- --version)"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec "${TEST_PKG_IDENT}" sensu-server -- --help
  [ "$status" -eq 0 ]
}
