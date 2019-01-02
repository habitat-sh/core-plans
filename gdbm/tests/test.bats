source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(gdbmtool --version | head -1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}
