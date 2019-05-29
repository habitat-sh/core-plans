TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} go version | awk '{print $3}')"
  [ "$result" = "go${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} go help
  [ $status -eq 0 ]
}

@test "Simple compile" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} go run ${BATS_TEST_DIRNAME}/hello.go)"
  status=$?
  [ $status -eq 0 ]
  [ "$result" = "Hello, 世界" ]
}
