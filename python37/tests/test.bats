TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} python --version | head -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} python --help
  [ "$status" -eq 0 ]
}

@test "Basic hello world" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} python ${BATS_TEST_DIRNAME}/test-hello-world.py)"
  [ $? -eq 0 ]
  [ "$result" = "Hello World" ]
}
