TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} pngquant -- --version | head -1 | awk '{print $1}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help Command Check" {
  run hab pkg exec ${TEST_PKG_IDENT} pngquant -- --help
  [ $status -eq 0 ]
}
