source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(rebar3 version | head -1 | awk '{print $2}')"
  [ $? -eq 0 ]
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run rebar3 help
  [ $status -eq 0 ]
}
