TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} dotnet -- --version)"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Info command" {
  run hab pkg exec ${TEST_PKG_IDENT} dotnet -- --info
  [ $status -eq 0 ]
}
