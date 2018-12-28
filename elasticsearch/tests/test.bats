source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(elasticsearch --version | awk '{print $2}' | tr -d ',')"
  [ "$result" = "${pkg_version}" ]
}
