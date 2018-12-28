source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(curl --version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}
