@test "Version matches plan" {
  TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" cmake --version | grep 'cmake version' | awk '{print $3}')"
  diff <( echo "$actual_version" ) <( echo "${TEST_PKG_VERSION}" )
}
