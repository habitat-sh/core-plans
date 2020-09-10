TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "busybox run successfully" {
  run hab pkg exec "${TEST_PKG_IDENT}" busybox
  [ $status -eq 0 ]
}

@test "busybox is statically linked" {
  file /hab/pkgs/"$TEST_PKG_IDENT"/bin/busybox |grep -q statically
  [ $? -eq 0 ]
}

@test "busybox linked applets correctly" {
  # In the past we've seen issues where `busybox --list` would fail silently
  # and the applet commands would not be linked, but the package would still
  # be generated. This checks the critical commands used in the studio
  # to ensure they're present. We don't check all though, there are >380!
  #
  # This is a somewhat awkward test, in that we're largely testing that our plan
  # is correct and plan-build behaved correctly. Due to the potential for silent
  # failures and the critical nature of this package and these commands, it's
  # worth validating.
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/awk ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/basename ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/bash ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/cat ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/chmod ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/chown ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/chroot ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/cut ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/cp ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/dirname ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/env ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/grep ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/id ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/install ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/ln ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/mkdir ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/mount ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/pwd ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/readlink ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/rm ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/sed ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/sh ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/stat ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/tr ]
  [ -s /hab/pkgs/$TEST_PKG_IDENT/bin/umount ]
}
