@test "libz.so exists" {
  [ -f "/hab/pkgs/$TEST_PKG_IDENT/lib/libz.so" ]
}
