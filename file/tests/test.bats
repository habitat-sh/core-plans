@test "Version matches" {
  expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
  result="$(hab pkg exec ${TEST_PKG_IDENT} file --version | head -1 | tr -d 'file-')"
  [ "$result" = "${expected_version}" ]
}
