source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(dotnet --version)"
  [ "$result" = "${pkg_version}" ]
}

@test "Info command" {
  run dotnet --info
  [ $status -eq 0 ]
}
