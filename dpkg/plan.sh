pkg_name=dpkg
pkg_origin=core
pkg_version=1.20.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later')
pkg_upstream_url="https://wiki.debian.org/dpkg"
pkg_description="dpkg is a package manager for Debian-based systems"
pkg_source="http://http.debian.net/debian/pool/main/d/${pkg_name}/${pkg_name}_${pkg_version}.tar.xz"
pkg_shasum="5ce242830f213b5620f08e6c4183adb1ef4dc9da28d31988a27c87c71fe534ce"
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
  core/perl
  core/pkg-config
  core/xz
  core/zlib
  core/diffutils
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  export LDFLAGS="$LDFLAGS -Wl,--copy-dt-needed-entries"
}

do_check() {
  make check
}
