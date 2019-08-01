setup() {
  TEST_PKG_PATH="/hab/pkgs/$TEST_PKG_IDENT"
  GLIBC_VERSION="$(cut -d/ -f3 $TEST_PKG_PATH/IDENT)"
}

@test "its abi version is 3.2.0" {
  output="$(readelf -n "$TEST_PKG_PATH/lib/libc-$GLIBC_VERSION.so" | grep "OS: Linux, ABI:" | awk '{ print $4 }')"

  [ "$output" == "3.2.0" ]
}

# This is a test performed as part of `make check` but will always be a false positive
# https://sourceware.org/glibc/wiki/Testing/Testsuite#abi-check
# We expect this to always be 54 for us:
# /hab/pkgs/core/glibc/2.29/20190624135026/share/locale
@test "it has the correct length for _dl_default_dirname" {
  length="$(readelf -s "$TEST_PKG_PATH/lib/libc-$GLIBC_VERSION.so" | grep -E "_nl_default_dirname" | awk '{ print $3 }' | tail -n1)"
  [ "$length" -eq 54 ]
}

# RTLDLIST contains elements we don't care about but aren't harmful to include. The first element should _ALWAYS_
# be present though, so we check for existance of that. This is somewhat brittle, but if glibc were to change the
# ordering it would mean unnecessary lookups. This isn't expected to happen, but may serve as a warning flag that
# the update in question bears a closer look.
@test "ldd has correct search path" {
  rtldlist="$(grep "^RTLDLIST=" "$TEST_PKG_PATH"/bin/ldd |cut -d'"' -f2 |cut -d' ' -f1)"

  [ "$rtldlist" == "$TEST_PKG_PATH/lib/ld-linux.so.2" ]
}

@test "ldd has correct textdomaindir" {
  textdomaindir="$(grep TEXTDOMAINDIR "$TEST_PKG_PATH"/bin/ldd | cut -d'=' -f2)"

  [ "$textdomaindir" == "$TEST_PKG_PATH/share/locale" ]
}

@test "ldconfig cache only contains this package" {
  # ldconfig --print-cache output looks like:
  # libutil.so.1 (libc6,x86-64, OS ABI: Linux 3.2.0) => /hab/pkgs/core/glibc/2.29/20190625200519/lib/libutil.so.1
  #
  # Test to ensure that the cache only contains items belonging to the current package

  output="$($TEST_PKG_PATH/bin/ldconfig --print-cache | tail -n +1 | awk '{print $8}')"
  for line in $output; do
    library="$(echo $line | cut -d/ -f1-7)"
    [ "$library" == "$TEST_PKG_PATH" ]
  done
}

@test "tzselect prints correct timezone information" {
  # Send tzselect a known input and confirm the output is what we expect
  # This should validate that it has the timezone data embedded in the package
  zone=$("$TEST_PKG_PATH"/bin/tzselect << EOF | tail -n1
2
49
22
1
EOF)

  [ "$zone" == "America/Anchorage" ]
}
