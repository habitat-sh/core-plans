@test "package directory for package ident ${PACKAGE_IDENT} exists" {
  [ -d "/hab/pkgs/${PACKAGE_IDENT}" ]
}

@test "'ldd /hab/pkgs/${PACKAGE_IDENT}/lib/*.so*' indicates no dynamic linking issues" {
  run ldd /hab/pkgs/${PACKAGE_IDENT}/lib/*.so*
  [ $status -eq 0 ]
}
