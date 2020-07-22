TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} kubectl version --client | head -1 | awk '{print $5}')"
  [ "$result" = "GitVersion:\"v${TEST_PKG_VERSION}\"," ]
}
