@test "Version matches plan" {
  TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" xz --version | awk '/XZ Utils/{print $0}')"
  diff <( echo "$actual_version" ) <( echo "xz (XZ Utils) ${TEST_PKG_VERSION}" )
}
