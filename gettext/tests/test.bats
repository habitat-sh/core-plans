@test "gettext displays help" {
  run hab pkg exec $TEST_PKG_IDENT gettext --help
  [ "$status" -eq 0 ]
}
