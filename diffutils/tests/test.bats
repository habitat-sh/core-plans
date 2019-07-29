@test "diff on the same inputs" {
  alpha="${BATS_TEST_DIRNAME}/fixtures/alpha"
  run hab pkg exec ${TEST_PKG_IDENT} diff "$alpha" "$alpha"
  [ "$status" -eq 0 ]
}

@test "diff on the different inputs" {
  alpha="${BATS_TEST_DIRNAME}/fixtures/alpha"
  beta="${BATS_TEST_DIRNAME}/fixtures/beta"
  run hab pkg exec ${TEST_PKG_IDENT} diff "$alpha" "$beta"
  [ "$status" -eq 1 ]
}

@test "cmp on the same inputs" {
  gamma="${BATS_TEST_DIRNAME}/fixtures/gamma"
  run hab pkg exec ${TEST_PKG_IDENT} diff "$gamma" "$gamma"
  [ "$status" -eq 0 ]
}

@test "cmp on the different inputs" {
  gamma="${BATS_TEST_DIRNAME}/fixtures/gamma"
  delta="${BATS_TEST_DIRNAME}/fixtures/delta"
  run hab pkg exec ${TEST_PKG_IDENT} cmp "$gamma" "$delta"
  [ "$status" -eq 1 ]
}
