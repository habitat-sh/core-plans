build_line "Using hardened build flags"
#
# Stack canaries
#
# -fstack-protector-strong provides more protection than
# --fstack-protector without the performance hit of
# --fstack-protector-all.
#
# See: https://lwn.net/Articles/584225/
#
DEFAULT_HARDENING_CFLAGS="-fstack-protector-strong"
#
# RELRO
#
# Sets relocation-related memory sections to read-only before
# execution is turned over to the program, preventing overwriting of
# the Global Offset Table.
#
DEFAULT_HARDENING_LDFLAGS="-Wl,-z,relro"
#
# BIND_NOW
#
# Resolve all symbols when loading the program rather than lazily.
# This, with RELRO, allows the entire GOT to be marked read-only.
#
DEFAULT_HARDENING_LDFLAGS="${DEFAULT_HARDENING_LDFLAGS} -Wl,-z,now"
#
# _FORTIFY_SOURCE is a glibc macro that adds checks to commonly
# misused functions in order to prevent buffe oveflow errors.
#
# _FORTIFY_SOURCE requires an optimized build of at least -O1.
#
# See: http://man7.org/linux/man-pages/man7/feature_test_macros.7.html
#
DEFAULT_HARDENING_CFLAGS="${DEFAULT_HARDENING_CFLAGS} -O2"
DEFAULT_HARDENING_CPPFLAGS="-D_FORTIFY_SOURCE=2"


export CFLAGS="$CFLAGS $DEFAULT_HARDENING_CFLAGS"
export CPPFLAGS="$CPPFLAGS $DEFAULT_HARDENING_CPPFLAGS"
export CXXFLAGS="$CXXLAGS $DEFAULT_HARDENING_CFLAGS"
export LDFLAGS="$LDFLAGS $DEFAULT_HARDENING_LDFLAGS"
