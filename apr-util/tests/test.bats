@test "package directory for package ident ${TEST_PKG_IDENT} exists" {
  [ -d "/hab/pkgs/${TEST_PKG_IDENT}" ]
}

expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
@test "apu-1-config exe runs" {
  run hab pkg exec $TEST_PKG_IDENT apu-1-config --bindir
  [ $status -eq 0 ]
}

@test "apu-1-config exe output mentions expected version $expected_version" {
  run hab pkg exec $TEST_PKG_IDENT apu-1-config --version
  [[ "$output" =~ $expected_version ]]
}
