pkg_name=grep
pkg_origin=core
pkg_version=3.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv3+')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=db625c7ab3bb3ee757b3926a5cfa8d9e1c3991ad24707a83dde8a5ef2bf7a07e
pkg_deps=(core/glibc core/pcre)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/perl)
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

}
do_check() {
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
  pkg_build_deps=(core/gcc core/coreutils)
fi
