@test "autoconf displays help" {
  run hab pkg exec $TEST_PKG_IDENT autoconf --help
  [ "$status" -eq 0 ]
}
