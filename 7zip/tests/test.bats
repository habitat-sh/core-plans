@test "package directory for package ident ${TEST_PACKAGE_IDENT} exists" {
  [ -d "/hab/pkgs/${TEST_PACKAGE_IDENT}" ]
}

expected_version="$(echo $TEST_PACKAGE_IDENT | cut -d/ -f 3)"
@test "7z exe runs" {
  run hab pkg exec $TEST_PACKAGE_IDENT 7z
  [ $status -eq 0 ]
}

@test "7z exe output mentions expected version $expected_version" {
  run hab pkg exec $TEST_PACKAGE_IDENT 7z
  [[ "$output" =~ 7-Zip\ \[64\]\ $expected_version ]]
}

@test "7za exe runs" {
  run hab pkg exec $TEST_PACKAGE_IDENT 7za
  [ $status -eq 0 ]
}

@test "7za exe output mentions expected version $expected_version" {
  run hab pkg exec $TEST_PACKAGE_IDENT 7za
  [[ "$output" =~ 7-Zip\ \(a\)\ \[64\]\ $expected_version ]]
}
