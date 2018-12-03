source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(protoc --version)"
  [ "$result" = "libprotoc ${pkg_version}" ]
}

@test "Help command" {
  run protoc --help
  [ $status -eq 0 ]
}
