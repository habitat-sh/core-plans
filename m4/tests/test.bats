@test "m4 --version output mentions expected version" {
  expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
  actual_version=$(hab pkg exec $TEST_PKG_IDENT m4 --version | head -n1 | cut -d' '  -f4)

  [ "$actual_version" = "$expected_version" ]
}
