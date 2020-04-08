TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} iperf3 --version 2>&1 | head -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

# Running --help always exits 1
@test "Execution success" {
  run hab pkg exec ${TEST_PKG_IDENT} iperf3 --version
  [ $status -eq 0 ]
}
