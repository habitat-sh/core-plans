@test "zsh runs" {
  run hab pkg exec $TEST_PKG_IDENT zsh -- -c 'true'
  [ $status -eq 0 ]
}

@test "zsh --version output mentions expected version $expected_version" {
  expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
  actual_version=$(hab pkg exec $TEST_PKG_IDENT zsh -- --version | cut -d\  -f2)
  [ "$actual_version" = "$expected_version" ]
}
