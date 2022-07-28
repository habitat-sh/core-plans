pkg_name=xlib
pkg_distname=libX11
pkg_origin=core
pkg_version=1.7.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 protocol client library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum=1cfa35e37aaabbe4792e9bb690468efefbfbf6b147d9c69d6f90d13c3092ea6c
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
  core/libxau
  core/libxcb
  core/libxdmcp
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/inputproto
  core/kbproto
  core/libpthread-stubs
  core/make
  core/perl
  core/pkg-config
  core/util-macros
  core/xextproto
  core/xproto
  core/xtrans
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}
do_check() {
    make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
