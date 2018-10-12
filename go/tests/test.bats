source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(go version | awk '{print $3}')"
  [ "$result" = "go${pkg_version}" ]
}

@test "Help command" {
  run go help
  [ $status -eq 0 ]
}
