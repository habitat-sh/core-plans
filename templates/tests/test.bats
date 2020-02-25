TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "version matches" {
  # The most basic test checks that the program executes and matches
  # the expected version. For example:
  #
  #     result="$(hab pkg exec ${TEST_PKG_IDENT} PROGRAM --version 2>&1 | head -1)"
  #     [ "${result}" = "${TEST_PKG_VERSION}" ]
  #
  false
}
