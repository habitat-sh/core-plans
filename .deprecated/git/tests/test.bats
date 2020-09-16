@test "Version matches plan" {
  TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" git --version | awk '{print $3}')"
  diff <(echo "$actual_version") <( echo "${TEST_PKG_VERSION}")
}

@test "Init a git repo" {
  run hab pkg exec "${TEST_PKG_IDENT}" git init git_test_repo
  [ $status -eq 0 ]
  [ -d git_test_repo/.git ]
  rm -rf git_test_repo
}
