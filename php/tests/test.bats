TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} php -- --version | head -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "libzip support" {
  run hab pkg exec ${TEST_PKG_IDENT} php "${BATS_TEST_DIRNAME}/libzip_support.php"
  [ $status -eq 0 ]
}

@test "gettext support" {
  run hab pkg exec ${TEST_PKG_IDENT} php "${BATS_TEST_DIRNAME}/gettext_support.php"
  [ $status -eq 0 ]
}
