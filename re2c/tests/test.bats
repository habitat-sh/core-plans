source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v re2c)" ]
}

@test "Version matches" {
  result="$(re2c -v)"
  [ "$result" = "re2c ${pkg_version}" ]
}

@test "Help command" {
  run re2c -h
  [ $status -eq 0 ]
}
