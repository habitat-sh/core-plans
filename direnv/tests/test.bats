source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  run direnv version
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "${pkg_version}" ]
}

@test "Help command" {
  run direnv help
  [ "$status" -eq 0 ]
}

@@test "Status check" {
    run direnv status
    [ "$status" -eq 0 ]
}
