source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(vault version | awk '{print $2}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Help command" {
  run vault --help
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Usage: vault <command> [args]" ]
}
