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
  length="$(readelf -s "$TEST_PKG_PATH/lib/libc-$GLIBC_VERSION.so" | grep "_nl_default_dirname" | awk '{ print $3 }')"

  [ $length -eq 54 ]
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
