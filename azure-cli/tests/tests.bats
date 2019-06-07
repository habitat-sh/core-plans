TEST_PKG_VERSION="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"

@test "az exe runs" {
  run hab pkg exec $TEST_PKG_IDENT az
  [ $status -eq 0 ]
}

@test "az exe outputs the expected version $TEST_PKG_VERSION" {
  result="$(hab pkg exec $TEST_PKG_IDENT az --version | grep 'azure-cli (' | awk '{gsub(/azure-cli\ \(|\)/,"")}1')"
  [ "$result" = $TEST_PKG_VERSION ]
}
