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
  alpha="${BATS_TEST_DIRNAME}/fixtures/alpha"
  run hab pkg exec ${TEST_PKG_IDENT} diff "$alpha" "$alpha"
  [ "$status" -eq 0 ]
}

@test "cmp on the different inputs" {
  alpha="${BATS_TEST_DIRNAME}/fixtures/alpha"
  beta="${BATS_TEST_DIRNAME}/fixtures/beta"
  run hab pkg exec ${TEST_PKG_IDENT} cmp "$alpha" "$beta"
  [ "$status" -eq 1 ]
}
