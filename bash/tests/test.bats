expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "bash matches version ${expected_version}" {
  # actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" bash --version | awk '{print $0}')"
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" bash --version | grep -oP '(?<=GNU bash, version )([^(]*)' )"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}
