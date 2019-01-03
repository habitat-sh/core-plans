source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(getent --version | head -1 | awk '{print $4}')"
  [ "$result" = "${pkg_version}" ]
}
