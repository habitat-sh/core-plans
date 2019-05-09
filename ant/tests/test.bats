source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(hab pkg exec "${PKGIDENT}" ant -version | awk '{print $4}')"
  [ "$result" = "${pkg_version}" ]
}
