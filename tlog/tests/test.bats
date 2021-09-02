TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" tlog-play -- --version 2>/dev/null | egrep -a 'tlog [0-9]+' | head -n1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "tlog-play command" {
  run hab pkg exec "${TEST_PKG_IDENT}" tlog-play -- --help
  [ $status -eq 0 ]
}

@test "tlog-rec command" {
  run hab pkg exec "${TEST_PKG_IDENT}" tlog-rec -- --help
  [ $status -eq 0 ]
}

@test "tlog-rec-session command" {
  run hab pkg exec "${TEST_PKG_IDENT}" tlog-rec-session -- --help
  [ $status -eq 0 ]
}
