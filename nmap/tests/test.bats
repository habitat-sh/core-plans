TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} nmap -- --version | grep version | awk '{print $3}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}
