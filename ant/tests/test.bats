source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(ant -version | awk '{print $4}')"
  [ "$result" = "${pkg_version}" ]
}
