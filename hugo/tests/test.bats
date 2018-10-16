source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(hugo version | awk '{print $5}')"
  [ "$result" = "v${pkg_version}" ]
}
