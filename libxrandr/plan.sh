pkg_name=libxrandr
pkg_distname=libXrandr
pkg_origin=core
pkg_version=1.5.2
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X Resize and Rotate library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum=8aea0ebe403d62330bb741ed595b53741acf45033d3bda1792f1d4cc3daee023
pkg_deps=(core/glibc core/libxrender core/xlib core/libxcb core/libxau core/libxdmcp core/libxext)
pkg_build_deps=(core/diffutils core/gcc core/make core/pkg-config core/util-macros core/renderproto core/xproto core/kbproto core/libpthread-stubs core/xextproto core/randrproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
