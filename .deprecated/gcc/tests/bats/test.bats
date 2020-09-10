setup() {
  TEST_PKG_PATH="/hab/pkgs/$TEST_PKG_IDENT"
  BINUTILS_DEP=$(grep binutils /hab/pkgs/$TEST_PKG_IDENT/DEPS)
  GLIBC_DEP=$(grep glibc /hab/pkgs/$TEST_PKG_IDENT/DEPS)
}

# gcc,g++ and cpp are wrapped with shell scripts to allow us to carefully set the
# environment and flags passed to the underlying command. Testing core/gcc is best
# tested by building additional software with the resulting package. The following
# asserts that we didn't have an unexpected failure or accidental change in our
# build process by asserting:
#
# That the commmand are shell scripts
# That the `.real` command exists and is executable
# That the final line in the script is an exec to become the real command

@test "gcc is wrapped" {
  [ "$(file -bi "$TEST_PKG_PATH"/bin/gcc)" == "text/x-shellscript; charset=us-ascii" ]
  [ -x "$TEST_PKG_PATH"/bin/gcc.real ]

  [ "$(tail -n1 "$TEST_PKG_PATH"/bin/gcc | cut -d' ' -f1,2)" == "exec $TEST_PKG_PATH/bin/gcc.real" ]
}

@test "g++ is wrapped" {
  [ "$(file -bi "$TEST_PKG_PATH"/bin/g++)" == "text/x-shellscript; charset=us-ascii" ]
  [ -x "$TEST_PKG_PATH"/bin/g++.real ]

  [ "$(tail -n1 "$TEST_PKG_PATH"/bin/g++ | cut -d' ' -f1,2)" == "exec $TEST_PKG_PATH/bin/g++.real" ]
}

@test "cpp is wrapped" {
  [ "$(file -bi "$TEST_PKG_PATH"/bin/cpp)" == "text/x-shellscript; charset=us-ascii" ]
  [ -x "$TEST_PKG_PATH"/bin/cpp.real ]

  [ "$(tail -n1 "$TEST_PKG_PATH"/bin/cpp | cut -d' ' -f1,2)" == "exec $TEST_PKG_PATH/bin/cpp.real" ]
}

# We also need to be certain our wrapper scripts have the expected binutils and glibc version.
# This is a safeguard against an accidental build where glibc or binutils resolved to the wrong
# version during generation of the scripts. This is most likely to occur in a refresh-type scenario
# where multiple pieces of software (including hab-plan-build) are being updated and built as a
# group.

@test "binutils and glibc paths in wrappers are correct" {
  export DEBUG=true
  run hab pkg exec $TEST_PKG_IDENT gcc
  [ "$(grep "\-B/hab/pkgs/core/binutils" <<< "$output")" == "  -B/hab/pkgs/${BINUTILS_DEP}/bin/" ]
  [ "$(grep "\-B/hab/pkgs/core/glibc" <<< "$output")" == "  -B/hab/pkgs/${GLIBC_DEP}/lib/" ]
  unset DEBUG
}
