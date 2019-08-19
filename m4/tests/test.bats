expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "m4 matches version ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" m4 --version | grep "m4 (GNU M4)" | awk '{print $4}')"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}
