source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Commands are on path" {
  [ "$(command -v llvm-config)" ]
}

@test "Version matches" {
  result="$(llvm-config --version)"
  [ "$result" = "${pkg_version}" ]
}

@test "Check libLTO.so exists" {
  run file "/hab/pkgs/${pkg_ident}/lib/libLTO.so"
  [ $status -eq 0 ]
}

@test "Check libLTO.so does not have any \"not found\" shared libs" {
  run bash -c "ldd \"/hab/pkgs/${pkg_ident}/lib/libLTO.so\" | grep \"not found\""
  [ $status -eq 1 ]
}
