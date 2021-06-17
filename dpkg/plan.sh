pkg_name=dpkg
pkg_origin=core
pkg_version=1.19.7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later')
pkg_upstream_url="https://wiki.debian.org/dpkg"
pkg_description="dpkg is a package manager for Debian-based systems"
pkg_source="http://http.debian.net/debian/pool/main/d/${pkg_name}/${pkg_name}_${pkg_version}.tar.xz"
pkg_shasum="4c27fededf620c0aa522fff1a48577ba08144445341257502e7730f2b1a296e8"
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
