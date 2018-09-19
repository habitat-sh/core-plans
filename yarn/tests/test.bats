source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(yarn --version)"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run yarn --Help
  [ "$status" -eq 0 ]
}
