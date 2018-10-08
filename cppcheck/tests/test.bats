source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v cppcheck)" ]
}

@test "Version matches" {
  result="$(cppcheck --version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help Command Check" {
  run cppcheck --help
  [ $status -eq 0 ]
}
