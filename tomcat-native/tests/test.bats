@test "package directory for package ident ${TEST_PKG_IDENT} exists" {
  [ -d "/hab/pkgs/${TEST_PKG_IDENT}" ]
}

@test "'ldd /hab/pkgs/${PACKAGE_IDENT}/lib/*.so*' indicates no dynamic linking issues" {
  run ldd /hab/pkgs/${TEST_PKG_IDENT}/lib/*.so*
  [ $status -eq 0 ]
}
