source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(docker --version | awk '{print $3}' | tr -d ',')"
  [ "$result" = "${pkg_version}" ]
}
