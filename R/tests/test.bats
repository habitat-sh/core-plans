TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" R --version | head -n1 | awk '{print $3}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "R command" {
  run hab pkg exec "${TEST_PKG_IDENT}" R --help
  [ $status -eq 0 ]
}
