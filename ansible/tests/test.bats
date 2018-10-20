source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(ansible --version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help Command" {
  run ansible --help
  [ $status -eq 0 ]
}
