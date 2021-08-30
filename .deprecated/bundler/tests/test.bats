expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f3)"

@test "bundler runs" {
  run hab pkg exec $TEST_PKG_IDENT bundle -v
  [ $status -eq 0 ]
}

@test "bundler is expected version ${expected_version}" {
  actual_version=$(hab pkg exec $TEST_PKG_IDENT bundle -v | grep -o '[^\ ]*$')
  [ "${actual_version}" = "${expected_version}" ]
}
