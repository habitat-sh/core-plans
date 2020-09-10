@test "Parses well-formed xml" {
  run hab pkg exec $TEST_PKG_IDENT xmlwf $BATS_TEST_DIRNAME/fixtures/valid.xml
  [ "$output" == "" ]
}

@test "Reports error on non-well-formed xml" {
  run hab pkg exec $TEST_PKG_IDENT xmlwf $BATS_TEST_DIRNAME/fixtures/mismatched-tag.xml
  grep "mismatched tag" <<< "$output"
}
