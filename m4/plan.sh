# Disable shellcheck that would require quotes around pkg_name
# shellcheck disable=SC2209
pkg_name=m4
pkg_origin=core
pkg_version=1.4.19
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU M4 is an implementation of the traditional Unix macro processor. It is \
mostly SVR4 compatible although it has some extensions (for example, handling \
more than 9 positional parameters to macros). GNU M4 also has built-in \
functions for including files, running shell commands, doing arithmetic, etc.\
"
pkg_upstream_url="http://www.gnu.org/software/m4"
pkg_license=('gplv3')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/make
  core/gcc
  core/binutils
  core/diffutils
)
pkg_bin_dirs=(bin)

do_prepare() {
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
