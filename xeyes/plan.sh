pkg_name=xeyes
pkg_origin=core
pkg_version=1.2.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="xeyes"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/app/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=f8a17e23146bef1ab345a1e303c6749e42aaa7bcf4f25428afad41770721b6db
pkg_deps=(
  core/glibc
  core/xlib
  core/libxcb
  core/libxau
  core/libxdmcp
  core/libxt
  core/libice
  core/libsm
  core/libxext
	core/libxrender
  core/libxmu
  core/xextproto
  core/renderproto
  core/libxi
  core/inputproto
  core/fixesproto
  core/libxfixes
  core/xproto
  core/kbproto
)
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_check() {
    make check
}
