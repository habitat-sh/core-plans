source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(pngcrush --version 2>&1 | head -1 | awk -F' |,' '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run pngcrush --help
  [ $status -eq 0 ]
}
