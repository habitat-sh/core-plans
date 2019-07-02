source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Commands are on path" {
  [ "$(command -v clang)" ]
  [ "$(command -v clang++)" ]
  [ "$(command -v clang-format)" ]
  [ "$(command -v clang-tidy)" ]
}

@test "Version matches" {
  result="$(clang --version | head -1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]

  result="$(clang++ --version | head -1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help Command Check" {
  run clang --help
  [ $status -eq 0 ]

  run clang++ --help
  [ $status -eq 0 ]
}

@test "Check libclang.so exists" {
  run file "/hab/pkgs/${pkg_ident}/lib/libclang.so"
  [ $status -eq 0 ]
}

@test "Check libclang.so does not have any \"not found\" shared libs" {
  run bash -c "ldd \"/hab/pkgs/${pkg_ident}/lib/libclang.so\" | grep \"not found\""
  [ $status -eq 1 ]
}
