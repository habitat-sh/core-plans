pkg_name=libarchive
_distname=$pkg_name
pkg_origin=core
pkg_version="3.8.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Multi-format archive and compression library"
pkg_upstream_url="https://www.libarchive.org"
pkg_license=('BSD')
pkg_source="http://www.libarchive.org/downloads/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="bde832a5e3344dc723cfe9cc37f8e54bde04565bfe6f136bc1bd31ab352e9fab"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
  core/openssl
  core/zlib
  core/bzip2
  core/xz
)
pkg_build_deps=(
  core/gcc
  core/coreutils
  core/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

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
  make check
}
