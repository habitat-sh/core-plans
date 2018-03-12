pkg_name=sqlcipher
pkg_origin=core
pkg_version=3.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-3-Clause")
pkg_source="https://github.com/$pkg_name/$pkg_name/archive/v$pkg_version.tar.gz"
pkg_shasum=4172cc6e5a79d36e178d36bd5cc467a938e08368952659bcd95eccbaf0fa4ad4
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/binutils
  core/diffutils
  core/coreutils
  core/gawk
  core/gcc
  core/grep
  core/make
  core/sed
  core/tcl
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="SQLCipher is an SQLite extension that provides 256 bit AES encryption of database files."
pkg_upstream_url="https://www.zetetic.net/sqlcipher/"

do_prepare() {
  export CFLAGS="$CFLAGS -DSQLITE_HAS_CODEC"
  build_line "Setting CFLAGS=$CFLAGS"
}

do_build() {
  ./configure --build=x86_64 --enable-tempstore=yes --prefix="$pkg_prefix"
  make
}
