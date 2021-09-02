TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  hab pkg exec ${TEST_PKG_IDENT} svn --version | head -1 | awk '{print $3}'
  result=$(hab pkg exec ${TEST_PKG_IDENT} svn -- --version | head -1 | awk '{print $3}')
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} svn --help
  [ $status -eq 0 ]
}

@test "Create repository" {
  run hab pkg exec ${TEST_PKG_IDENT} svnadmin create ./test-repo
  [ $status -eq 0 ]
  rm -rf ./test-repo
}
