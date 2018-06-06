pkg_name=file
pkg_origin=core
pkg_version=5.32
pkg_description="Ian Darwin's implementation of the Unix File(1) command."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_source=ftp://ftp.astron.com/pub/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_upstream_url=https://www.darwinsys.com/file/
pkg_shasum=8639dc4d1b21e232285cd483604afc4a6ee810710e00e579dbe9591681722b50
pkg_deps=(core/glibc core/zlib)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  # Add explicit linker instructions as the binutils we are using may have its
  # own dynamic linker defaults. This is necessary because this Plan is built
  # before the `binutils` Plan which will set the new `glibc` dynamic
  # linker for all later Plans.
  dynamic_linker="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
  export LDFLAGS
  build_line "Updating LDFLAGS=$LDFLAGS"
}

do_check() {
  make check
}

do_install() {
  make install

  # As per the copyright, we must include the copyright statement in binary
  # distributions
  #
  # Source: https://github.com/file/file/blob/master/COPYING
  install -v -Dm644 COPYING "$pkg_prefix/share/COPYING"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=()
fi
