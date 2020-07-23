source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(ghc --version | awk '{print $8}')"
  [ "$result" = "${pkg_version}" ]
}
