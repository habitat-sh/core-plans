source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(dovecot --version | awk '{print $1}')"
  [ "$result" = "${pkg_version}" ]
}
