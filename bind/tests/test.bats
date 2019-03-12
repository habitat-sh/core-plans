source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches for named" {
  result="$(named -v | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}
