TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} mage -- --version 2>&1 | head -1)"
  [ "${result}" = "Mage Build Tool v${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} mage --help
  [ $status -eq 0 ]
}

@test "Mage init works" {
  [ ! -f magefile.go ]
  hab pkg exec ${TEST_PKG_IDENT} mage -init
  [ -f magefile.go ]
  rm -f magefile.go
}
