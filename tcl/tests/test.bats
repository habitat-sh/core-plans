@test "simple tcl expression" {
  run hab pkg exec $TEST_PKG_IDENT tclsh "$BATS_TEST_DIRNAME"/fixtures/simple.tcl
  [ "$output" == "4" ]
}
