TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} elixir --version | tail -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Trivial Elixir code tests" {
  run hab pkg exec ${TEST_PKG_IDENT} elixir -e "is_atom :ok"
  [ $status -eq 0 ]
}
