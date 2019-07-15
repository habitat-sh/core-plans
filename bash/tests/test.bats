@test "can execute commands" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} bash -c 'echo "$BASH"' )"
  [ "$result" == "/hab/pkgs/$TEST_PKG_IDENT/bin/bash" ]
}
