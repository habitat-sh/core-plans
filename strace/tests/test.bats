TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" strace -- -V | head -1 | awk '{print $4}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Can strace" {
  run hab pkg exec "${TEST_PKG_IDENT}" strace strace -h
  [ $status -eq 0 ]
}
