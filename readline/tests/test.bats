@test "libreadline.so exists" {
  [ -f "/hab/pkgs/$TEST_PKG_IDENT/lib/libreadline.so" ]
}

# Check that the patch to link to ncurses works
@test "libreadline.so is linked to ncurses" {
  ldd /hab/pkgs/$TEST_PKG_IDENT/lib/libreadline.so | grep ncurses
}

@test "libhistory.so is linked to ncurses" {
  ldd /hab/pkgs/$TEST_PKG_IDENT/lib/libhistory.so | grep ncurses
}
