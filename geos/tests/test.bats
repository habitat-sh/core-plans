source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(geos-config --version)"
  [ "$result" = "${pkg_version}" ]
}
