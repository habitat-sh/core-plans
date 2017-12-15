pkg_name=m4
pkg_origin=core
pkg_version=1.4.18
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv3')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=f2c1e86ca0a404ff281631bdc8377638992744b175afb806e25871a24a934e07
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/binutils)
pkg_bin_dirs=(bin)

do_prepare() {
  # Fix failing test `test-getopt-posix` which appears to have problems when
  # working against Glibc 2.26.
  #
  # TODO fn: when glibc package is upgraded, see if this patch is still
  # required (it may be fixed in the near future)
  #
  # Thanks to:
  # https://www.redhat.com/archives/libvir-list/2017-September/msg01054.html
  patch -p1 < "$PLAN_CONTEXT/fix-test-getopt-posix-with-glibc-2.26.patch"

  # Force gcc to use our ld wrapper from binutils when calling `ld`
  CFLAGS="$CFLAGS -B$(pkg_path_for binutils)/bin/"
  build_line "Updating CFLAGS=$CFLAGS"

  # Add explicit linker instructions as the binutils we are using may have its
  # own dynamic linker defaults.
  dynamic_linker="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
  build_line "Updating LDFLAGS=$LDFLAGS"
}

do_check() {
  # Fixes a broken test with either gcc 5.2.x and/or perl 5.22.x:
  # FAIL: test-update-copyright.sh
  #
  # Thanks to: http://permalink.gmane.org/gmane.linux.lfs.devel/16285
  sed -i 's/copyright{/copyright\\{/' build-aux/update-copyright

  make check
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/binutils)
fi
