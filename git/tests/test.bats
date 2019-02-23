source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(git --version | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}
