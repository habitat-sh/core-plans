@test "Version matches plan" {
  TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" getfacl --version | awk '{print $2}')"
  [[ "$actual_version" = "${TEST_PKG_VERSION}" ]]
}
