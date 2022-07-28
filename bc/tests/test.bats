@test "Version is correct" {
  expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
  result="$(hab pkg exec ${TEST_PKG_IDENT} bc -v | head -1)"
  [ "$result" = "bc ${expected_version}" ]
}

@test "Simple calculation" {
  run hab pkg exec ${TEST_PKG_IDENT} bc <<< '1 + 1'
  [ $status -eq 0 ]
  [ $output = '2' ]
}
