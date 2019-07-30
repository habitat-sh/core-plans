@test "Make simple task" {
  run hab pkg exec "$TEST_PKG_IDENT" make --directory "$BATS_TEST_DIRNAME/fixtures/" ci-test
  grep -q "Make in CI" <<< "$output"
}
