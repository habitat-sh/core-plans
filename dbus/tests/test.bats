source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(dbus-daemon --version | head -1 | awk '{print $5}')"
  [ "$result" = "${pkg_version}" ]
}
