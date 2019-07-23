@test "Can execute simple command" {
  run hab pkg exec ${TEST_PKG_IDENT} gzip --help

  [ "$status" -eq 0 ]
}
