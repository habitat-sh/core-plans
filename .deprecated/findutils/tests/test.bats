@test "Simple find with exec" {
  run hab pkg exec "${TEST_PKG_IDENT}" find -name plan.sh
  [ "$status" -eq 0 ]
}
