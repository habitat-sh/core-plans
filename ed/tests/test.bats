TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} ed -- --version 2>&1 | head -1)"
  [[ "$?" -eq 0 ]];
  diff -u <(echo "${result}") <(echo "GNU ed ${TEST_PKG_VERSION}")
}
