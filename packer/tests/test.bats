source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(packer version | head -1 | awk '{print $2}')"
  [ "$result" = "v${pkg_version}" ]
}
