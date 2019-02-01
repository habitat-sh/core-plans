source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(supervisord -v)"
  [ "$result" = "${pkg_supervisor_version}" ]
}
