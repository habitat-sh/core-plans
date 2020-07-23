TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "alex runs with exit status 1" {
  run hab pkg exec "${TEST_PKG_IDENT}" alex
  [ $status -eq 1 ]
}

@test "alex --help runs with exit status 0" {
  run hab pkg exec "${TEST_PKG_IDENT}" alex --help
  [ $status -eq 0 ]
}

@test "alex -v output mentions expected version" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" alex -v | awk -F',' '{print $1}')"
  [ "$result" = "Alex version ${TEST_PKG_VERSION}" ]
}

@test "alex simple token file succeeds" {
  run hab pkg exec "${TEST_PKG_IDENT}" alex ${BATS_TEST_DIRNAME}/test.x
  [ $status -eq 0 ]
  [ -f ${BATS_TEST_DIRNAME}/test.hs ]
  rm -f ${BATS_TEST_DIRNAME}/test.hs
}
