pkg_name=libmpc
_distname=mpc
pkg_origin=core
pkg_version=1.2.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU MPC is a C library for the arithmetic of complex numbers with arbitrarily \
high precision and correct rounding of the result.\
"
pkg_upstream_url="http://www.multiprecision.org/"
pkg_license=('LGPL-3.0-or-later')
pkg_source="https://ftp.gnu.org/gnu/${_distname}/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
  core/gmp
  core/mpfr
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
  core/binutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  build_line "Updating LDFLAGS=$LDFLAGS"

  # GCC will set the dynamic linker if we don't provide it. Since this package
  # is built after glibc, but before GCC, we would end with segfaults during the
  # build process because it will set the RPATH to look at _new_ glibc, but the
  # dynamic linker will be the _old_ glibc. By setting it here, we ensure that
  # all the versions line up.
  dynamic_linker="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  CFLAGS="$CFLAGS -Wl,--dynamic-linker=$dynamic_linker"
  build_line "Updating CFLAGS=$CFLAGS"
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
  pkg_build_deps=(
    core/binutils
  )
fi
