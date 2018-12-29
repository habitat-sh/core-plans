source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$($(hab pkg path ${HAB_ORIGIN}/file)/bin/file --version | head -1 | tr -d 'file-')"
  [ "$result" = "${pkg_version}" ]
}
