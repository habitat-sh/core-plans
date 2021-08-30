TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" mvn --version | head -n1 | awk '{print $3}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "mvn command" {
  run hab pkg exec "${TEST_PKG_IDENT}" mvn --help
  [ $status -eq 0 ]
}
