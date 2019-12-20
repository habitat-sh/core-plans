expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f3)"

@test "ruby runs" {
  run hab pkg exec $TEST_PKG_IDENT ruby -v
  [ $status -eq 0 ]
}

@test "is expected version ${expected_version}" {
  actual_version=$(hab pkg exec $TEST_PKG_IDENT ruby -v | grep -o 'ruby .*p')
  [ "${actual_version}" = "ruby ${expected_version}p" ]
}

@test "provides a gem command" {
  run hab pkg exec $TEST_PKG_IDENT gem env
  [ $status -eq 0 ]
}

@test "includes bundler" {
  run hab pkg exec $TEST_PKG_IDENT bundle -v
  [ $status -eq 0 ]
}
