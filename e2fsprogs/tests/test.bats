source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "uuidgen exit code check" {
  run uuidgen -t
  [ $status -eq 0 ]
}
