pkg_origin=core
pkg_name=libghthash
pkg_version=0.6.2
pkg_license=('LGPL-2.0')
pkg_description="Generic Hash Table which is meant to be easy to extend, portable, clear in its code and easy to use."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://github.com/SimonKagstrom/libghthash"
pkg_source="https://github.com/SimonKagstrom/libghthash/archive/v${pkg_version}.tar.gz"
pkg_shasum="e7e5f77df3e2a9152e0805f279ac048af9e572b83e60d29257cc754f8f9c22d6"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/gcc
  core/libtool
  core/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  sed -i 's/AM_PROG_LIBTOOL()/LT_INIT/g' configure.in
  echo "AC_CONFIG_MACRO_DIRS([m4])" >> configure.in

  libtoolize
  aclocal -I m4
  autoconf
  automake --add-missing

  do_default_build
}
