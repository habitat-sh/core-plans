TEST_PKG_MAGIC_PATH="$(hab pkg path ${TEST_PKG_IDENT})/share/misc/magic.mgc"

@test "Version matches" {
  expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
  result="$(hab pkg exec ${TEST_PKG_IDENT} file --version | head -1 | tr -d 'file-')"
  [ "$result" = "${expected_version}" ]
}

@test "Internal magic file in use" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} file --version | tail -1)"
  [ "$result" = "magic file from ${TEST_PKG_MAGIC_PATH%.*}" ]
}

@test "Command detects format of magic file" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} file ${TEST_PKG_MAGIC_PATH})"
  [ "$result" = "${TEST_PKG_MAGIC_PATH}: magic binary file for file(1) cmd (version 14) (little endian)" ]
}
