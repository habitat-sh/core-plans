source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Help command" {
  run sbt -help
  [ $status -eq 1 ]
}
