TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
echo "${TEST_PKG_IDENT}"
echo "${TEST_PKG_VERSION}"
@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} elixir -v | tail -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
echo "$result"
echo "${TEST_PKG_VERSION}"
}

@test "Trivial Elixir code tests" {
  run hab pkg exec ${TEST_PKG_IDENT} elixir -e "is_atom :ok"
  [ $status -eq 0 ]
}
