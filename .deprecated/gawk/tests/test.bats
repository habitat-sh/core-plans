@test "Expected version" {
  expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
  actual_version=$(hab pkg exec $TEST_PKG_IDENT gawk --version | head -1 | awk '{ print $3 }' | cut -d, -f1)
  [ "$expected_version" = "$actual_version" ]
}

basic_command() {
  echo | hab pkg exec $TEST_PKG_IDENT gawk '{ print 1+1 }'
}
@test "Basic execution" {
  run basic_command
  [ $status -eq 0 ]
  [ "$output" = '2' ]
}
