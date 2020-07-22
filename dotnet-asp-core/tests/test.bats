source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(dotnet --info | grep Version | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run dotnet --help
  [ $status -eq 129 ]
}

@test "ASP check" {
  result="$(dotnet --info | grep Microsoft.AspNetCore.App| awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}
