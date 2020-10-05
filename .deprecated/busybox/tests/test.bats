TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version is correct" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} busybox | head -1 | awk '{print $2}')"
  [ "$result" = "v${TEST_PKG_VERSION}" ]
}
