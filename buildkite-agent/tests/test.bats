source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(buildkite-agent --version | awk '{print $3}')"
  [ "$result" = "${pkg_version}," ]
}
