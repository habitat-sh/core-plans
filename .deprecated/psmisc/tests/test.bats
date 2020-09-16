@test "pstree is expected version" {
  expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
  actual_version="$(hab pkg exec $TEST_PKG_IDENT pstree --version 2>&1 | head -1 | awk '{print $3}')"
  [ "$expected_version" = "$actual_version" ]
}

@test "prtstat runs" {
  run hab pkg exec $TEST_PKG_IDENT prtstat $$
  [ $status -eq 0 ]
}
