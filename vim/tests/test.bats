TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} vim --version | head -n3 | tail -n1)"
  [ "$result" = "Compiled by Habitat, vim release ${TEST_PKG_VERSION}" ]
}
