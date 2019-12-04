expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "make matches version ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" make --version | grep "GNU Make" | awk '{print $3}')"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}

@test "Make simple task" {
  run hab pkg exec "$TEST_PKG_IDENT" make --directory "$BATS_TEST_DIRNAME/fixtures/" ci-test
  grep -q "Make in CI" <<< "$output"
}
