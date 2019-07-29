@test "texinfo displays help" {
  run hab pkg exec $TEST_PKG_IDENT info --help
  [ "$status" -eq 0 ]
}
