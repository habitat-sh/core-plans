TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} goiardi --version | head -1 | awk '{print $3}')"
  [ $? -eq 0 ]
  [ "$result" = "${TEST_PKG_VERSION}" ]
}
