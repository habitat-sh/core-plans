pkg_name=libxt
pkg_distname=libXt
pkg_origin=core
pkg_version=1.2.1
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 toolkit intrinsics library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="679cc08f1646dbd27f5e48ffe8dd49406102937109130caab02ca32c083a3d60"
pkg_deps=(core/glibc core/xlib core/libxcb core/libxau core/libxdmcp core/libsm core/libice)
pkg_build_deps=(core/gcc core/make core/pkg-config core/xproto core/kbproto core/libpthread-stubs)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
