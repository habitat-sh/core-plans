source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(envdir --version)"
  [ "$result" = "${pkg_version}" ]
}
