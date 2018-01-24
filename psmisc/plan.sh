pkg_name=psmisc
pkg_origin=core
pkg_version=23.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gpl')
pkg_source=http://downloads.sourceforge.net/psmisc/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=2e84d474cf75dfbe3ecdacfb797bbfab71a35c7c2639d1b9f6d5f18b2149ba30
pkg_deps=(core/glibc core/ncurses)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc)
pkg_bin_dirs=(bin)


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/gcc)
fi
