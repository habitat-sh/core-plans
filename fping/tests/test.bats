source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(fping --version | head -1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Can ping a host" {
  result="$(fping 8.8.8.8)"
  [ "$result" = "8.8.8.8 is alive" ]
}
