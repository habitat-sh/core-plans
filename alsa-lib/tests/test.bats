@test "libraries are dynamically linked" {
  run ldd /hab/pkgs/$TEST_PKG_IDENT/lib/libasound.so*
  [ $status -eq 0 ]
}

@test "aserver is dynamically linked" {
  run ldd /hab/pkgs/$TEST_PKG_IDENT/bin/aserver
  [ $status -eq 0 ]
}

@test "aserver help command works" {
  run /hab/pkgs/$TEST_PKG_IDENT/bin/aserver --help
  [ $status -eq 0 ]
}
