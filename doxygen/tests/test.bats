source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(doxygen --version)"
  [ "$result" = "${pkg_version}" ]
}
