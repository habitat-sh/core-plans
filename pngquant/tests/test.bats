source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v pngquant)" ]
}

@test "Version matches" {
  result="$(pngquant --version | head -1 | awk '{print $1}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help Command Check" {
  run pngquant --help
  [ $status -eq 0 ]
}
