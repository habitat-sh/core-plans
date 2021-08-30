TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} tmux -- -V | head -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}
