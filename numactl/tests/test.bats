@test "numastat can run" {
  run hab pkg exec ${TEST_PKG_IDENT} numastat
  [ $status -eq 0 ]
}
