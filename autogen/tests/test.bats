TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Autogen version command returns expected version" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" autogen -- --version | cut -d' ' -f4)"
  [ "$result" = "$TEST_PKG_VERSION"  ]
}
