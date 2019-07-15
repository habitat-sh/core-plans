TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} flex --version)"
  [ "$result" = "flex ${TEST_PKG_VERSION}" ]
}
