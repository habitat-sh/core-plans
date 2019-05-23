TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Package and library Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" sassc --version | grep 'sassc:' | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]

  result="$(hab pkg exec "${TEST_PKG_IDENT}" sassc --version | grep 'libsass:' | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec "${TEST_PKG_IDENT}" sassc --help
  [ "$status" -eq 0 ]
}
