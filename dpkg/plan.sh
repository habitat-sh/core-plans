pkg_name=dpkg
pkg_origin=core
pkg_version=1.19.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_upstream_url=https://wiki.debian.org/dpkg
pkg_description="dpkg is a package manager for Debian-based systems"
pkg_source=http://http.debian.net/debian/pool/main/d/${pkg_name}/${pkg_name}_${pkg_version}.tar.xz
pkg_shasum=c15234e98655689586bff2d517a6fdc6135d139c54d52ae9cfa6a90007fee0ae
pkg_deps=(
  core/bzip2
  core/glibc
  core/tar
  core/zlib
  core/xz
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/bzip2
  core/gcc
  core/gettext
  core/libtool
  core/patch
  core/make
  core/ncurses
  core/perl
  core/pkg-config
  core/xz
  core/zlib
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_description="Debian Package Manager"

do_build() {
  export prefix=$pkg_prefix
  do_default_build
}

do_install() {
  export prefix=$pkg_prefix
  do_default_install
}
