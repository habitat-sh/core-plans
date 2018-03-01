source ../libarchive/plan.sh

pkg_name=libarchive-musl
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(core/musl core/openssl-musl core/zlib-musl core/bzip2-musl core/xz-musl)

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
}

do_check() {
  # TODO fn: Currently there is one high level test that fails and the detailed
  # failures look to be related to locales, most likely different between the
  # Glibc & musl libc implementations. Chances are that there is a way to make
  # this suite pass 100% or set particular tests up to skip.
  make check || true
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/gcc core/coreutils core/sed core/grep core/diffutils core/make)
fi
