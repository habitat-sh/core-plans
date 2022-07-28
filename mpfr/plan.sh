pkg_name=mpfr
pkg_origin=core
pkg_version=4.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU MPFR (GNU Multiple Precision Floating-Point Reliably) is a GNU portable \
C library for arbitrary-precision binary floating-point computation with \
correct rounding, based on GNU Multi-Precision Library.\
"
pkg_upstream_url="http://www.mpfr.org/"
pkg_license=('LGPL-3.0-or-later')
pkg_source="http://www.mpfr.org/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f"
pkg_deps=(
  core/glibc
  core/gmp
)
pkg_build_deps=(
  core/patch
  core/make
  core/gcc
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

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-gmp="$(pkg_path_for gmp)" \
    --enable-thread-safe
  make -j"$(nproc)"
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
