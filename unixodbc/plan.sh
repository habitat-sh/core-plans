pkg_name=unixodbc
pkg_origin=core
pkg_version=2.3.9
pkg_license=('LGPL2.1')
pkg_upstream_url="http://www.unixodbc.org/"
pkg_description="ODBC driver manager for Unix"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-${pkg_version}.tar.gz"
pkg_shasum="52833eac3d681c8b0c9a5a65f2ebd745b3a964f208fc748f977e44015a31b207"
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
