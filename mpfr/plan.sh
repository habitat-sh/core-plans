pkg_name=mpfr
pkg_origin=core
pkg_version=4.0.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU MPFR (GNU Multiple Precision Floating-Point Reliably) is a GNU portable \
C library for arbitrary-precision binary floating-point computation with \
correct rounding, based on GNU Multi-Precision Library.\
"
pkg_upstream_url="http://www.mpfr.org/"
pkg_license=('lgpl')
pkg_source="http://www.mpfr.org/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="67874a60826303ee2fb6affc6dc0ddd3e749e9bfcb4c8655e3953d0458a6e16e"
pkg_deps=(
  core/glibc
  core/gmp
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
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
