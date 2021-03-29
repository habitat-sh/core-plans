pkg_name=dpkg
pkg_origin=core
pkg_version=1.20.7.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later')
pkg_upstream_url="https://wiki.debian.org/dpkg"
pkg_description="dpkg is a package manager for Debian-based systems"
pkg_source="http://http.debian.net/debian/pool/main/d/${pkg_name}/${pkg_name}_${pkg_version}.tar.xz"
pkg_shasum="0aad2de687f797ef8ebdabc7bafd16dc1497f1ce23bd9146f9aa73f396a5636f"
pkg_deps=(
  core/bzip2
  core/glibc
  core/ncurses
  core/tar
  core/zlib
  core/xz
  core/gcc-libs
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
  core/perl
  core/pkg-config
  core/xz
  core/zlib
  core/diffutils
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
	make check
}
