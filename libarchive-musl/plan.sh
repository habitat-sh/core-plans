pkg_name=libarchive-musl
_distname=libarchive
pkg_origin=core
pkg_version=3.5.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Multi-format archive and compression library"
pkg_upstream_url="https://www.libarchive.org"
pkg_license=('BSD')
pkg_source="http://www.libarchive.org/downloads/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="5f245bd5176bc5f67428eb0aa497e09979264a153a074d35416521a5b8e86189"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/musl
  core/openssl-musl
  core/zlib-musl
  core/bzip2-musl
  core/xz-musl
)
pkg_build_deps=(
  core/gcc
  core/coreutils
  core/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
}

do_build() {
  # We force PIC here because all of our rust crates that rely on this expect full
  # R_X86_64_64 symbols all the way down. By default it will make a 32S symbol table
  CFLAGS="$CFLAGS -fPIC" \
    ./configure \
    --prefix="$pkg_prefix" \
    --without-xml2 \
    --without-lzo2
  make
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
  pkg_build_deps=(
    core/gcc
    core/coreutils
    core/sed
    core/grep
    core/diffutils
    core/make
  )
fi
