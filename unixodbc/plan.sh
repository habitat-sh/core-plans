pkg_name=unixodbc
pkg_origin=core
pkg_version=2.3.6
pkg_license=('LGPL2.1')
pkg_upstream_url="http://www.unixodbc.org/"
pkg_description="ODBC driver manager for Unix"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-${pkg_version}.tar.gz"
pkg_shasum="88b637f647c052ecc3861a3baa275c3b503b193b6a49ff8c28b2568656d14d69"
pkg_dirname="unixODBC-${pkg_version}"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

pkg_deps=(
  core/glibc
  core/libtool
)

pkg_build_deps=(
  core/binutils
  core/gcc
  core/make
)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --disable-gui

  make
}
