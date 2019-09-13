expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "rustc matches version ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" rustc --version | grep rustc | sed -n '{s/nightly//g; s/[()]//g; p}' | awk '{print $2  $4}')"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}
