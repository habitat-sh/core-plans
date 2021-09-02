expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "jruby matches version ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" jruby -- --version | awk '{print $2}')"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}
