pkg_name=xeyes
pkg_origin=core
pkg_version=1.1.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="xeyes"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/app/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="975e98680cd59e1f9439016386609546ed08c284d0f05a95276f96aca6e8a521"
pkg_deps=(core/glibc
          core/xlib
          core/libxcb
          core/libxau
          core/libxdmcp
          core/libxt
          core/libice
          core/libsm
          core/libxext
	  core/libxrender
          core/libxmu)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto core/kbproto core/libpthread-stubs core/xextproto core/renderproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_check() {
    make check
}
