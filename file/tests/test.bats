TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
TEST_PKG_MAGIC_PATH="/hab/pkgs/${TEST_PKG_IDENT}/share/misc/magic.mgc"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} file --version | head -1)"
  [ "$result" = "file-${TEST_PKG_VERSION}" ]
}

@test "Internal magic file in use" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} file --version | tail -1)"
  [ "$result" = "magic file from ${TEST_PKG_MAGIC_PATH}" ]
}

@test "MAGIC env exported" {
  result="$(bash -c 'source <(hab pkg env ${TEST_PKG_IDENT}) && echo $MAGIC')"
  [ "$result" = "${TEST_PKG_MAGIC_PATH}" ]
}

@test "Command detects format of magic file" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} file ${TEST_PKG_MAGIC_PATH})"
  [ "$result" = "${TEST_PKG_MAGIC_PATH}: magic binary file for file(1) cmd (version 14) (little endian)" ]
}
