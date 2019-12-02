TEST_PKG_VERSION="$(echo ${TEST_PKG_IDENT} | cut -d/ -f 3)"

@test "az exe runs" {
  run hab pkg exec ${TEST_PKG_IDENT} az
  [ $status -eq 0 ]
}

@test "az exe outputs the expected version" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} az --version | grep "azure-cli " | awk '{print $2}')"
  [ "$result" = ${TEST_PKG_VERSION} ]
}
