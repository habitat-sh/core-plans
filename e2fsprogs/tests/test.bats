TEST_PKG_VERSION="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"

@test "uuidgen works" {
  run hab pkg exec "${TEST_PKG_IDENT}" uuidgen -t
  [ "$status" -eq 0 ]
}
