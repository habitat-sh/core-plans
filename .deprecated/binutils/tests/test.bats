@test "ld.bfd sets -rpath" {
  # Set up our LD_RUN_PATH to simulate what plan-build would do.
  # Use multiple entries to ensure splitting is performed correctly
  LD_RUN_PATH="/foo/bar:/baz/lib"

  # hab pkg exec will unset LD_RUN_PATH, so we need to call the full
  # path in this case.
  DEBUG=true LD_RUN_PATH=$LD_RUN_PATH run /hab/pkgs/$TEST_PKG_IDENT/bin/ld.bfd

  # output is newline separated. Pass --null-data to grep to treat the
  # input as one long line
  #
  # The debug output looks like
  #  -rpath
  #  /path/to
  # for every entry in LD_RUN_PATH.  Since we're validating the multiple input
  # scenario here, we have this fun regex in order to ensure our input is
  # present in its entirety.
  grep -E --null-data -- "-rpath\s+\/foo\/bar\s+-rpath\s+\/baz\/lib" <<< "${output[@]}"
}

@test "ld.bfd sets -dynamic-linker" {
  # We need to ensure that the -dynamic-linker is set to the glibc ld-linux-x86_64.so.2
  # that this package was set with. First, pull out the fully qualified ident for glibc
  # from the DEPS.
  glibc_dep="/hab/pkgs/$(grep "core/glibc/" /hab/pkgs/$TEST_PKG_IDENT/DEPS)"

  DEBUG=true run hab pkg exec $TEST_PKG_IDENT ld.bfd

  # output is newline separated. Pass --null-data to grep to treat the input as
  # one long line
  grep -E --null-data -- "-dynamic-linker\s+${glibc_dep}" <<< "${output[@]}"
}
