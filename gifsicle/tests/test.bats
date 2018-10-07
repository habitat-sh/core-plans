source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v gifsicle)" ]
}

@test "Version matches" {
  result="$(gifsicle --version | head -1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help Command Check" {
  run gifsicle --help
  [ $status -eq 0 ]
}
