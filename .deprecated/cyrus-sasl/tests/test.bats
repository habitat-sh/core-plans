TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" saslauthd -v 2>&1 | head -n1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "saslauthd command" {
  run hab pkg exec "${TEST_PKG_IDENT}" saslauthd -h 2>&1
  [ $status -eq 0 ]
}
