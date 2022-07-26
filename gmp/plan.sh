pkg_name=gmp
pkg_origin=core
pkg_version=6.2.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GMP is a free library for arbitrary precision arithmetic, operating on signed \
integers, rational numbers, and floating-point numbers.\
"
pkg_upstream_url="https://gmplib.org"
pkg_license=('GPL-3.0-or-later')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="fd4829912cddd12f84181c3451cc752be224643e87fac497b69edddadc49b4f2"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/binutils
  core/m4
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  # Set RUNPATH for c++ compiled code
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
    --enable-fat \
    --build=x86_64-unknown-linux-gnu
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
    core/m4
  )
fi
