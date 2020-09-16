TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Automake version command returns expected version" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" automake --version | head -1 | cut -d' ' -f4)"
  [ "$result" = "$TEST_PKG_VERSION"  ]
}

@test  "aclocal displays help" {
  run hab pkg exec $TEST_PKG_IDENT aclocal --help
  [ "$status" -eq 0 ]
}
