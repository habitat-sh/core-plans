source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(elixir --version | tail -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Trivial Elixir code tests" {
  run elixir -e "is_atom :ok"
  [ $status -eq 0 ]
}
