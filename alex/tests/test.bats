@test "package directory for package ident ${TEST_PKG_IDENT} exists" {
  [ -d "/hab/pkgs/${TEST_PKG_IDENT}" ]
}

expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
@test "alex exe runs" {
  run hab pkg exec $TEST_PKG_IDENT alex -v
  [ $status -eq 0 ]
}

@test "alex -v output mentions expected version $expected_version" {
  run hab pkg exec $TEST_PKG_IDENT alex -v
  [[ "$output" =~ $expected_version ]]
}
