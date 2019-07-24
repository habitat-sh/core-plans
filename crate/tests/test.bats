expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "crate matches version ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" crate -v | awk '{print $2}' | cut -d',' -f1)"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}
