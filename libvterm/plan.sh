pkg_name=libvterm
pkg_origin=core
pkg_version="0+bzr726"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="http://www.leonerd.org.uk/code/$pkg_name/$pkg_name-${pkg_version}.tar.gz"
pkg_shasum="6344eca01c02e2270348b79e033c1e0957028dbcd76bc784e8106bea9ec3029d"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/gcc
  core/libtool
  core/make
  core/perl
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_description="An abstract library implementation of a VT220/xterm/ECMA-48 terminal emulator."
pkg_upstream_url="http://www.leonerd.org.uk/code/libvterm/"

do_build() {
  make PREFIX="$pkg_prefix"
}

do_install() {
  make install PREFIX="$pkg_prefix"
}
