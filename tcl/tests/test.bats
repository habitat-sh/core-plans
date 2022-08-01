expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "tclsh matches version ${expected_version}" {
  actual_version="$(echo "puts [info patchlevel]" | hab pkg exec "${TEST_PKG_IDENT}" tclsh)"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}

@test "simple tcl expression" {
  run hab pkg exec $TEST_PKG_IDENT tclsh "$BATS_TEST_DIRNAME"/fixtures/simple.tcl
  [ "$output" == "4" ]
}
