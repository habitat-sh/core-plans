@test "patch displays help" {
  run hab pkg exec $TEST_PKG_IDENT patch --help
  [ "$status" -eq 0 ]
}
