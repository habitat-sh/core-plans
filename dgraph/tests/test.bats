source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(dgraph version | grep 'Dgraph version' | awk '{print $4}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Help command is functional" {
  run dgraph help
  [ $status -eq 0 ]
}
