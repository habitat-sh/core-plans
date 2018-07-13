pkg_name=freetds
pkg_origin=core
pkg_version=1.00.91
pkg_license=('LGPL2')
pkg_upstream_url="http://www.freetds.org"
pkg_description="FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.freetds.org/files/stable/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="4218c83dc7d8f8c6e1f53b7d40233226ac5c3cf407de00b21952c0dd3a218311"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

pkg_deps=(
  core/glibc
  core/libtool
  core/openssl
  core/unixodbc
  core/zlib
)

pkg_build_deps=(
  core/binutils
  core/gcc
  core/make
)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-msdblib \
    --with-unixodbc="$(pkg_path_for unixodbc)" \
    --with-openssl="$(pkg_path_for openssl)"

  make
}
