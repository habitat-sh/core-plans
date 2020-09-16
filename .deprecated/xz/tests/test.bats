expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "xz version matches ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" xz --version | awk '/XZ Utils/{print $4}')"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}
