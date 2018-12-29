source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(exercism --version | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}
