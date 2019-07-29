@test  "aclocal displays help" {
  run hab pkg exec $TEST_PKG_VERSION aclocal --help
  [ "$status" -eq 0 ]
}
